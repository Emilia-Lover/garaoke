# 나의 노래책 (공유판) 배포 가이드

이 폴더는 **모두에게 보이는 진짜 공유 사이트**로 만들기 위한 코드예요.
- 노래 목록(제목, 가수, TJ/KY 번호, 이미지, 가사, 링크): Supabase 데이터베이스에 저장 → **모두에게 공유**
- 노래 추가/수정/삭제: 공유 비밀번호(`0816`)를 입력해야 가능
- 내 목록(폴더/플레이리스트): 각자의 브라우저에만 저장 → **개인별로 다름**

아래 순서대로 진행하면 돼요. 계정 만들기·버튼 클릭은 직접 하셔야 하는 부분이에요.

## 1. Supabase 프로젝트 만들기 (데이터베이스)

1. https://supabase.com 접속 → "Start your project" → **GitHub으로 로그인**
2. "New project" 클릭 → 프로젝트 이름 아무거나(예: songbook) → 데이터베이스 비밀번호는 아무거나 정해서 저장해두기 → 리전은 가까운 곳(Northeast Asia 등) → Create
3. 생성되면 왼쪽 메뉴에서 **SQL Editor** 클릭 → New query
4. 이 폴더의 `supabase_schema.sql` 파일 내용을 전부 복사해서 붙여넣고 **Run** 클릭
   - 성공하면 노래 12곡이 미리 채워진 `songs` 테이블이 생겨요
5. 왼쪽 메뉴 **Project Settings → API** 로 이동해서 아래 두 값을 복사해두기 (나중에 Vercel에 입력할 거예요)
   - `Project URL` (예: `https://xxxxx.supabase.co`)
   - `service_role` 키 (⚠️ secret 키예요. 남에게 공유하면 안 돼요)

## 2. GitHub 저장소 만들기

1. https://github.com/new 에서 새 저장소 생성 (이름 예: `songbook-shared`, Public 또는 Private 아무거나)
2. 저장소를 만들고 나면 뜨는 안내 화면의 저장소 주소를 복사해두기 (예: `https://github.com/아이디/songbook-shared.git`)

그 다음, 이 폴더에서 아래 명령을 실행해서 코드를 올려요 (Claude가 대신 실행해드릴 수 있어요 — 저장소 주소만 알려주세요):

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <위에서 복사한 저장소 주소>
git push -u origin main
```

## 3. Vercel에 배포하기

1. https://vercel.com 접속 → **GitHub으로 로그인**
2. "Add New... → Project" → 방금 만든 `songbook-shared` 저장소 선택 → Import
3. **Environment Variables** 섹션에서 아래 3개를 추가:
   | Name | Value |
   |---|---|
   | `SUPABASE_URL` | 1단계에서 복사한 Project URL |
   | `SUPABASE_SERVICE_KEY` | 1단계에서 복사한 service_role 키 |
   | `EDIT_PASSWORD` | `0816` |
4. **Deploy** 클릭
5. 배포가 끝나면 `https://songbook-shared-아무개.vercel.app` 같은 주소가 생겨요. 이 주소를 아무에게나 공유하면 다 같이 볼 수 있어요.

## 4. 확인하기

- 사이트에 들어가서 노래가 12곡 보이면 성공
- "노래 추가"를 눌러보고 비밀번호를 물어보면 `0816` 입력 → 저장되는지 확인
- 다른 브라우저(시크릿 모드)나 다른 사람 폰으로 들어가도 방금 추가한 곡이 보이면 공유가 잘 되는 거예요
- "★ 내 목록"에서 만든 폴더는 그 브라우저에만 남아요 (의도한 동작이에요)

## 나중에 코드를 더 수정하고 싶다면

이 폴더의 `index.html`, `api/songs.js`를 수정한 뒤:
```bash
git add .
git commit -m "설명"
git push
```
하면 Vercel이 자동으로 다시 배포해줘요.
