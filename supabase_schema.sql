-- 1) Run this whole file once in Supabase: Project → SQL Editor → New query → paste → Run

create table if not exists songs (
  id text primary key,
  title text not null,
  artist text not null,
  genre text not null,
  tj text,
  ky text,
  mr_url text,
  original_url text,
  lyrics_url text,
  lyrics_text text,
  image_url text,
  created_at timestamptz not null default now()
);

alter table songs enable row level security;

-- anyone can read the shared songbook
drop policy if exists "public read" on songs;
create policy "public read" on songs
  for select
  using (true);

-- no insert/update/delete policy is created for the anon/public role on purpose.
-- all writes go through the /api/songs serverless function, which uses the
-- service role key (bypasses RLS) and checks the shared edit password itself.

insert into songs (id, title, artist, genre, tj, ky, mr_url, original_url, lyrics_url, lyrics_text, image_url) values
('seed-0','밤편지','아이유(IU)','kpop','48879','49492','https://www.youtube.com/watch?v=KfrWNlb_cM0','https://www.youtube.com/watch?v=BzYnNdJhZQw','https://www.melon.com/song/lyrics.htm?songId=30314784','','https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/dc/12/fe/dc12fe03-172b-a843-0d96-12819fa05b6c/cover-.jpg/600x600bb.jpg'),
('seed-1','Dynamite','방탄소년단(BTS)','kpop','75520','28017','https://www.youtube.com/watch?v=d5ValQHR_9A','https://www.youtube.com/watch?v=gdZLi9oWNZg','https://www.melon.com/song/detail.htm?songId=32872978','','https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/03/8d/0e/038d0e52-e96d-f386-b8eb-9f77fa013543/195497146918_Cover.jpg/600x600bb.jpg'),
('seed-2','Hype Boy','뉴진스(NewJeans)','kpop','82072','28907','https://www.youtube.com/watch?v=nTL2KONavNQ','https://www.youtube.com/watch?v=11cta61wi0g','https://www.melon.com/song/detail.htm?songId=35454426','','https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/4e/64/34/4e64344b-3ac6-c503-2c41-257a15401416/192641873096_Cover.jpg/600x600bb.jpg'),
('seed-3','나만, 안되는 연애','볼빨간사춘기','kpop','46885','76046','https://www.youtube.com/watch?v=ywtC1m5qzpY','https://www.youtube.com/watch?v=odU9v2HKwb0','https://www.melon.com/song/detail.htm?songId=9620473','','https://img.youtube.com/vi/ywtC1m5qzpY/hqdefault.jpg'),
('seed-4','Lemon','요네즈 켄시(米津玄師)','jpop','28822','44253','https://www.youtube.com/watch?v=2phgR8sqZg8','https://www.youtube.com/watch?v=SX_ViT4Ra7k','https://www.melon.com/song/detail.htm?songId=30952294','','https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/86/b0/9d/86b09d63-367a-563a-1e24-d5d62c220ac8/jacket_SRCL09749B00Z_550.jpg/600x600bb.jpg'),
('seed-5','Pretender','오피셜히게단디즘(Official髭男dism)','jpop','68058','44438','https://www.youtube.com/watch?v=ZeBdwEcTbV8','https://www.youtube.com/watch?v=TQ8WlA2GXbk','https://www.melon.com/song/detail.htm?songId=31802584','','https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/1f/b6/36/1fb6364f-77fc-7653-3750-811631832ee9/PCCA_04785.jpg/600x600bb.jpg'),
('seed-6','First Love','우타다 히카루(宇多田ヒカル)','jpop','확인필요','41017','https://www.youtube.com/watch?v=m3kJVN85nqQ','https://www.youtube.com/watch?v=o1sUaVJUeB0','https://www.melon.com/song/lyrics.htm?songId=21616159','','https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/77/67/00/77670013-e2ed-437a-dc30-e9cb74056cbe/00600406427052.rgb.jpg/600x600bb.jpg'),
('seed-7','群青(군조)','YOASOBI','jpop','68390','44684','https://www.youtube.com/watch?v=Z8MWZWX-6tw','https://www.youtube.com/watch?v=Y4nEEZwckuU','https://www.melon.com/song/detail.htm?songId=32889134','','https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/7e/4a/ae7e4a28-fd46-9617-1066-fcbd124303d6/195497105656.jpg/600x600bb.jpg'),
('seed-8','Perfect','Ed Sheeran','pop','확인필요','확인필요','https://www.youtube.com/watch?v=JIxz6_VsmD4','https://www.youtube.com/watch?v=2Vv-BfVoq4g','https://www.melon.com/song/lyrics.htm?songId=30208025','','https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/15/e6/e8/15e6e8a4-4190-6a8b-86c3-ab4a51b88288/190295851286.jpg/600x600bb.jpg'),
('seed-9','Someone Like You','Adele','pop','22204','확인필요','https://www.youtube.com/watch?v=NQ3XxgfHCmE','https://www.youtube.com/watch?v=hLQl3WQQoQ0','https://www.melon.com/song/detail.htm?songId=36591811','','https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/eb/ca/25/ebca2596-cd1e-b295-91a3-771c868d0a79/191404113868.png/600x600bb.jpg'),
('seed-10','Just The Way You Are','Bruno Mars','pop','확인필요','확인필요','https://www.youtube.com/watch?v=Umgc1hN3bPk','https://www.youtube.com/watch?v=LjhCEhWiKXk','https://music.bugs.co.kr/track/2254063','','https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/98/ae/c2/98aec2e1-3be4-0311-1b44-69348fc87abb/075679956484.jpg/600x600bb.jpg'),
('seed-11','Yellow','Coldplay','pop','20197','확인필요','https://www.youtube.com/watch?v=CjGkdIVT5T0','https://www.youtube.com/watch?v=yKNxeF4KMsY','https://www.melon.com/song/detail.htm?songId=39562505','','https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/f5/93/8c/f5938c49-964c-31d1-4b33-78b634f71fb7/190295978075.jpg/600x600bb.jpg')
on conflict (id) do nothing;
