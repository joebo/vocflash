load 'csv'
load 'strings'

coclass'vocflash'
coinsert'jhs'

DEBUG=:0

NB. http://www.jsoftware.com/docs/help701/phrases/random_numbers.htm
shuffle=: {~ ?~@#

render=: 3 : 0
'text/html' gsrcf (, L:0 ; ". each <;._2 html)
)


setLoadTime=: 3 : 0
LOAD=:(< 6!:0 'hh:mm:ss')
)

setLoadTime''
checkLatestScript=: 3 : 0
if. 0=((< 6!:0 'hh:mm:ss') -: LOAD) do.
  setLoadTime
  load jpath '~user/projects/vocflash/flash.ijs'
end.
)

Voc=:readcsv jpath '~user/projects/vocflash/vocab.csv'

vocOption=: 3 : 0
'Sym Text Args Desc'=.(y { Voc)
'<input type="radio" name="choice" value="',(": y),'">',Sym,'</input>'
)


NB. basic encode function
htmlencode =: 3 : 0
y rplc '<';'&lt;';'>';'&gt;';'"';'&quot;'
)

html =: 0 : 0
'<html>'
'<form method="post">'
'<h4>',Response,'</h4>'
'<h1>',Name,'</h1>'

'<input type="hidden" name="answer" value="',(": Answer),'"/">'
> vocOption each Choices
'<br><input type="submit">'
'<a href="#" onClick="alert(this.title)" title="',(htmlencode Help),'">hint</a>'
'</form>'
'</html>'
)

Welcome =: 0 : 0
Welcome, please select item that is defined by the statement below.
)

showForm =: 3 : 0
if. y<1 do.
  if. y = 0  do. Response=:'Correct!' else. Response=:Welcome end.
  Answer=: ? # Voc
else.
  Response=:'Try Again!'
  Answer=: y
end.

'Sym Text Args Desc'=.(Answer { Voc)

Name=: > Text
Help=: > Desc
Choices =: shuffle (Answer, (4 ? # Voc))
render html
)

jev_post_raw=: 3 : 0
NB. need to parse it manually and set proper locale val
NV_jhs_=:parse_jhs_ NV_jhs_
Answer=. ". getv'answer'
Choice =. ". '0',getv'choice'
showForm Answer*(Answer -.@= Choice)
)

jev_get=: 3 : 0
if. DEBUG do. checkLatestScript'' end.
showForm _1
)

NB. these are defined in j8, but apparently not j7 linux build
gsrchead=: toCRLF 0 : 0
HTTP/1.1 200 OK
Server: JHS
Last-Modified: Mon, 01 Mar 2010 00:23:24 GMT
Accept-Ranges: bytes
Content-Length: <LENGTH>
Keep-Alive: timeout=15, max=100
Connection: Keep-Alive
Content-Type: <TYPE>

)

gsrcf=: 4 : 0
htmlresponse y,~gsrchead rplc '<TYPE>';x;'<LENGTH>';":#y
)
