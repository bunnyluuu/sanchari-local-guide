CREATE TYPE public.app_role AS ENUM ('traveller', 'margadarshi');
CREATE TYPE public.assistance_status AS ENUM ('requested', 'accepted', 'active', 'completed', 'declined', 'cancelled');

CREATE TABLE public.user_roles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  role public.app_role NOT NULL,
  expires_at timestamptz NOT NULL DEFAULT (now() + interval '12 hours'),
  UNIQUE (user_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_roles TO authenticated;
GRANT ALL ON public.user_roles TO service_role;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own temporary role" ON public.user_roles FOR ALL TO authenticated USING (auth.uid() = user_id AND expires_at > now()) WITH CHECK (auth.uid() = user_id AND expires_at > now() AND expires_at <= now() + interval '24 hours');

CREATE TABLE public.profiles (
  user_id uuid PRIMARY KEY,
  display_name text NOT NULL CHECK (char_length(display_name) BETWEEN 2 AND 60),
  languages text[] NOT NULL DEFAULT '{}',
  is_online boolean NOT NULL DEFAULT false,
  verification_status text NOT NULL DEFAULT 'unverified' CHECK (verification_status IN ('unverified', 'prototype_verified')),
  last_seen_at timestamptz NOT NULL DEFAULT now(),
  expires_at timestamptz NOT NULL DEFAULT (now() + interval '12 hours')
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO authenticated;
GRANT ALL ON public.profiles TO service_role;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own temporary profile" ON public.profiles FOR ALL TO authenticated USING (auth.uid() = user_id AND expires_at > now()) WITH CHECK (auth.uid() = user_id AND expires_at > now() AND expires_at <= now() + interval '24 hours');
CREATE POLICY "Authenticated users view active profiles" ON public.profiles FOR SELECT TO authenticated USING (expires_at > now());

CREATE TABLE public.assistance_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  traveller_id uuid NOT NULL,
  margadarshi_id uuid,
  from_location text NOT NULL CHECK (char_length(from_location) BETWEEN 2 AND 160),
  destination text NOT NULL CHECK (char_length(destination) BETWEEN 2 AND 160),
  assistance_types text[] NOT NULL DEFAULT '{}',
  language text NOT NULL CHECK (char_length(language) BETWEEN 2 AND 60),
  duration_minutes integer NOT NULL CHECK (duration_minutes BETWEEN 15 AND 720),
  urgency text NOT NULL DEFAULT 'normal' CHECK (urgency IN ('normal', 'urgent')),
  natural_language_request text,
  ai_summary text,
  status public.assistance_status NOT NULL DEFAULT 'requested',
  created_at timestamptz NOT NULL DEFAULT now(),
  accepted_at timestamptz,
  started_at timestamptz,
  completed_at timestamptz,
  expires_at timestamptz NOT NULL DEFAULT (now() + interval '12 hours')
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.assistance_requests TO authenticated;
GRANT ALL ON public.assistance_requests TO service_role;
ALTER TABLE public.assistance_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Travellers create own requests" ON public.assistance_requests FOR INSERT TO authenticated WITH CHECK (auth.uid() = traveller_id AND margadarshi_id IS NULL AND status = 'requested' AND expires_at <= now() + interval '24 hours');
CREATE POLICY "Participants view requests" ON public.assistance_requests FOR SELECT TO authenticated USING (expires_at > now() AND (auth.uid() = traveller_id OR auth.uid() = margadarshi_id OR (status = 'requested' AND EXISTS (SELECT 1 FROM public.user_roles ur JOIN public.profiles p ON p.user_id = ur.user_id WHERE ur.user_id = auth.uid() AND ur.role = 'margadarshi' AND ur.expires_at > now() AND p.is_online AND p.expires_at > now()))));
CREATE POLICY "Travellers update own requests" ON public.assistance_requests FOR UPDATE TO authenticated USING (auth.uid() = traveller_id AND expires_at > now()) WITH CHECK (auth.uid() = traveller_id AND expires_at > now());
CREATE POLICY "Margadarshis update available or assigned requests" ON public.assistance_requests FOR UPDATE TO authenticated USING (expires_at > now() AND (margadarshi_id = auth.uid() OR (margadarshi_id IS NULL AND status = 'requested' AND EXISTS (SELECT 1 FROM public.user_roles ur JOIN public.profiles p ON p.user_id = ur.user_id WHERE ur.user_id = auth.uid() AND ur.role = 'margadarshi' AND ur.expires_at > now() AND p.is_online AND p.expires_at > now())))) WITH CHECK (expires_at > now() AND margadarshi_id = auth.uid());

CREATE TABLE public.assistance_reviews (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id uuid NOT NULL REFERENCES public.assistance_requests(id) ON DELETE CASCADE,
  traveller_id uuid NOT NULL,
  margadarshi_id uuid NOT NULL,
  rating integer NOT NULL CHECK (rating BETWEEN 1 AND 5),
  review text NOT NULL CHECK (char_length(review) BETWEEN 2 AND 800),
  created_at timestamptz NOT NULL DEFAULT now(),
  expires_at timestamptz NOT NULL DEFAULT (now() + interval '12 hours'),
  UNIQUE (request_id)
);
GRANT SELECT, INSERT ON public.assistance_reviews TO authenticated;
GRANT ALL ON public.assistance_reviews TO service_role;
ALTER TABLE public.assistance_reviews ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Participants view temporary reviews" ON public.assistance_reviews FOR SELECT TO authenticated USING (expires_at > now() AND (auth.uid() = traveller_id OR auth.uid() = margadarshi_id));
CREATE POLICY "Traveller reviews completed assistance" ON public.assistance_reviews FOR INSERT TO authenticated WITH CHECK (auth.uid() = traveller_id AND expires_at <= now() + interval '24 hours' AND EXISTS (SELECT 1 FROM public.assistance_requests ar WHERE ar.id = request_id AND ar.traveller_id = auth.uid() AND ar.margadarshi_id = assistance_reviews.margadarshi_id AND ar.status = 'completed' AND ar.expires_at > now()));

CREATE INDEX assistance_requests_status_expiry_idx ON public.assistance_requests(status, expires_at);
CREATE INDEX assistance_requests_traveller_idx ON public.assistance_requests(traveller_id, created_at DESC);
CREATE INDEX assistance_requests_margadarshi_idx ON public.assistance_requests(margadarshi_id, created_at DESC);
CREATE INDEX profiles_online_expiry_idx ON public.profiles(is_online, expires_at);

ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;
ALTER PUBLICATION supabase_realtime ADD TABLE public.assistance_requests;
ALTER PUBLICATION supabase_realtime ADD TABLE public.assistance_reviews;