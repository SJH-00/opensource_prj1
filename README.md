# opensource_prj1
1. 사용법<br/>
   ./prj1_12191785_shinjeonghyeok.sh u.item u.data u.user<br/>
   실행 후 메뉴의 9가지 옵션 중 원하는 기능의 번호를 입력한다.<br/>
   각 옵션에서 출력되는 메세지들을 읽고, 필요한 경우 원하는 선택지를 입력한다.
   
2. 구현 방법<br/>
   선택 메뉴를 출력한다.<br/>
   stop이라는 변수를 선언하여 'N'을 넣는다.<br/>
   stop 변수의 값이 'Y'가 될 때까지 옵션 번호를 입력받으며 case문을 반복한다.
   
   - 1번 기능 : u.item 파일에서 특정 movie id의 데이터 읽어오기<br/>
     read 명령어를 통해 사용자로부터 movie id를 입력받는다.<br/>
     cat 명령어를 사용해 u.item을 읽어온 후 awk의 입력으로 넘긴다.<br/>
     awk에서 |를 구분자로 지정하여 첫번째 열(movie id)과 입력받은 movie id를 비교하여 같은 행들을 출력한다.

   - 2번 기능 : u.item 파일에서 액션 장르 영화를 movie id 순으로 10개 읽어와서 'movie id' 'movie title' 형식으로 출력<br/>
     read 명령어를 통해 사용자가 y를 입력하면 다음 단계로 넘어가도록 한다. if문을 사용한다.<br/>
     cat 명령어를 사용해 u.item을 읽어온 후 awk의 입력으로 넘긴다.<br/>
     awk에서 |를 구분자로 지정하여 7번째 열(액션 장르)이 1로 설정되어 있는 행의 첫 번째 열(movie id)와 두 번째 열(movie title)을 출력한다.<br/>
     head 명령어를 이용해 movie id 순으로 10개의 행만 출력하도록 했다.

   - 3번 기능 : movie id를 입력받아 해당 영화의 평균 평점 확인<br/>
     read 명령어를 통해 평균 평점을 확인할 영화의 movie id를 입력받는다.<br/>
     cat 명령어를 사용해 u.data를 읽어온 후 awk의 입력으로 넘긴다.<br/>
     awk에서 v옵션을 통해 입력받은 movie id를 mid라는 변수에 저장해놓는다.<br/>
     두 번째 열(movie id)가 mid와 일치하는 행들을 찾아서 행마다 sum 변수에 3번째 열(평점)의 값을 더한다. cnt도 1씩 증가시킨다.<br/>
     해당 영화의 모든 평점을 다 더했다면, sum을 cnt로 나눈 후 출력한다. 평점을 더하는 과정이 완전히 끝난후 평균을 구하기 위해 END를 사용하고, 출력되는 평균 평점은 result라는 변수에 저장한다.<br/>
     printf에서 평균 평점을 소수점 6번째 자리에서 반올림 하여 소수점 5번째 자리까지만 출력한다.

   - 4번 기능 : u.item 파일의 내용에서 'IMDb URL' 부분을 삭제하고 10줄을 출력한다.<br/>
     read 명령어를 통해 사용자가 y를 입력하면 다음 단계로 넘어가도록 한다. if문을 사용한다.<br/>
     cat 명령어를 사용해 u.item을 읽어온 후 sed의 입력으로 넘긴다.<br/>
     url 부분이 http로 시작함을 이용한다. 또한 각 정보들이 |로 둘러싸여 있음을 이용한다.<br/>
     '|http'로 시작해서 '|'로 끝나는 문자열을 찾아 '||'로 바꾸어준다.<br/>
     '|http'와 '|'사이에 '|'가 아닌 문자들만 오는 문자열을 찾도록 해서, 원하는 부분만을 바꿀 수 있도록 구현했다.<br/>
     head 명령어를 이용하여 10개의 행만 출력하도록 했다.

   - 5번 기능 : u.user 파일에서 10명의 유저들의 정보를 읽어와서 user 'user id' is 'age' years old 'gender' 'occupation' 형식으로 출력한다. 10명의 정보만 출력한다.<br/>
     read 명령어를 통해 사용자가 y를 입력하면 다음 단계로 넘어가도록 한다. if문을 사용한다.<br/>
     cat 명령어를 사용해 u.user을 읽어온 후 sed의 입력으로 넘긴다.<br/>
     행의 시작에서 하나 이상의 숫자로만 이루어진 부분을 찾아 ()로 묶어 \1로 넘어갈 수 있도록 한다. user id 부분이다.<br/>
     그 후 'age', 'gender', 'occupation'은 차례대로 각각 '|'에 둘러싸여져서 나열되어 있다는 점을 이용한다.<br/>
     각각의 정보들을 '|'과 '|' 사이 '|'이 아닌 정보들로 처리해서 \2, \3, \4로 넘긴다.<br/>
     'user \1 is \2 years old \3 \4'로 출력한다.<br/>
     head 명령어를 이용하여 10명의 정보만 출력한다.

   - 6번 기능 : u.item 파일에서 release data 정보를 YYYYMMDD 형식으로 바꾼다( Ex) 01-Jan-1995 -> 19950101 ). 마지막 10개의 행만 출력한다.<br/>
     read 명령어를 통해 사용자가 y를 입력하면 다음 단계로 넘어가도록 한다. if문을 사용한다.<br/>
     cat 명령어를 사용해 u.item을 읽어온 후 sed의 입력으로 넘긴다.<br/>
     바꾸고자 하는 부분이 (숫자 2개)-(문자열)-(숫자 4개)의 형식으로 이루어져 있음을 이용한다. (괄호부분은 실제로 포함되어 있지 않다.)<br/>
     가운데 문자열 부분은 '-'가 아닌 문자들로 이루어진 부분을 찾는 방식으로 구현했다.<br/>
     각 부분을 \1, \2, \3으로 넘겨서 \3\2\1 형식으로 출력한다.<br/>
     아직 \2부분이 숫자가 아닌 문자열 상태이므로, sed의 e 옵션을 사용해서 1월부터 12월까지의 문자열들을 두자리 숫자로 바꾸어준다.<br/>
     tail 명령어를 이용하여 마지막 10개의 행만 출력한다.

   - 7번 기능 : 특정 유저가 평가한 영화들의 movie id를 나열하고, 그 중 10개의 영화들을 movie id가 작은 순으로 'movie id'|'movie title' 형식으로 출력한다.<br/>
     read 명령어를 통해 user id를 입력받는다.<br/>
     file1과 file2를 생성한다.<br/>
     cat 명령어를 사용해 u.data를 읽어온 후 awk의 입력으로 넘긴다.<br/>
     awk에서 v 옵션을 이용해 입력받은 user id를 uid라는 변수에 저장한다.<br/>
     u.data 파일에서 입력받은 uid와 첫번째 열이 일치하는 행에서 2번째 열(movie id)만 골라서 sort로 정렬해준 뒤 file 1에 저장한다.<br/>
     cat 명령어로 file1을 읽어와 awk로 넘겨준 후 'movie id'|'movie id'|'movie id'... 형식으로 출력한다.<br/>

     u.item의 첫번째 열(movie id)과 두번째 열(movie title)을 file2에 저장한다.<br/>
     awk에서 a라는 배열에 file2의 첫 번째 열을 인덱스 값으로 사용해서 행들을 저장한다.<br/>
     그 후 file1의 첫번째 열의 값이 배열 a에 있는 경우 해당 인덱스에 저장된 행을 출력한다.<br/>
     출력된 값을 sed의 input으로 넘겨주어 'movie id' 'movie title' 형식에서 중간 공백을 '|'로 대체하고 'movie id'|'movie title' 형식으로 출력한다.<br/>
     head 명령어를 이용하여 10개의 행만 출력한다.

   - 9번 기능 : 종료<br/>
     "Bye!"를 출력한 후 stop 변수의 값을 'Y'로 설정하여 case문을 벗어날 수 있도록 한다.
