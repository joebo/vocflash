load 'regex'
load 'csv'
require '~addons/ide/qt/help.ijs'
require '~addons/web/gethttp/gethttp.ijs'
load 'strings'

remote_dict=: 3 : 0
url=.'http://www.jsoftware.com/help/','.htm',~ helpsel_jqtide_ 
doc=.gethttp_wgethttp_ url y

showdoc doc
)


local_dict=: 3 : 0
path=:(jpath '~addons/docs/help/'),'.htm',~ helpsel_jqtide_ 
doc=.1!:1 <path y

showdoc doc
)


showdoc=: 3 : 0

addbreaks=. ('`';'';'&nbsp;';'';'&gt;';'>';'&lt;';'<';'&quot;';'"';'&amp;';'') stringreplace ]
striphtml=.('<(.|\n)+?>';'') rxrplc ]

html=:y

NB. need text/css as a hack to workaround the title from a 302 redirect
title=.< addbreaks > (1}"1 ('type="text/css"><title>(.+)</title>' rxmatches html) rxfrom html)

names=.1}"1 ('<font size=\+2>(.+)</font>' rxmatches html) rxfrom html
htmlnolf=.(CR;'';LF;'`') stringreplace html
cases=.('bgcolor="?#eeeeee"?>(.*?)</td>' rxmatches htmlnolf) rxfrom htmlnolf

smoutput title

html=.striphtml each (1{"1 cases)

(2 $ names),.('monad';'dyad'),.(2 {. (addbreaks each html))

)

j=. <;._2 (0 : 0)
= d000
=. d001
=: d001
< d010
<. d011
<: d012
> d020
>. d021
>: d022
_ d030
_. d031
_: d032
+ d100
+. d101
+: d102
* d110
*. d111
*: d112
- d120
-. d121
-: d122
% d130
%. d131
%: d132
^ d200
^. d201
^: d202n
$ d210
$. d211
$: d212
~ d220n
~. d221
~: d222
| d230
|. d231
|: d232
. d300
.. d301
.: d301
: d310n
:. d311
:: d312
, d320
,. d321
,: d322
; d330
;. d331
;: d332
# d400
#. d401
#: d402
! d410
!. d411
!: d412
/ d420
/. d421
/: d422
\ d430
\. d431
\: d432
[ d500
[: d502
] d500
{ d520
{. d521
{: d522
{:: d523
} d530n
}. d531
}: d532
" d600n
". d601
": d602
` d610
`: d612
@ d620
@. d621
@: d622
& d630n
&. d631
&: d632
&.: d631c
? d640
?. d640
__ d030
a. dadot
a: dadot
A. dacapdot
b. dbdotn
C. dccapdot
d. dddot
D. ddcapdot
D: ddcapco
e. dedot
E. decapdot
f. dfdot
H. dhcapdot
i. didot
i: dico
I. dicapdot
j. djdot
L. dlcapdot
L: dlcapco
M. dmcapdot
o. dodot
p. dpdot
p.. dpdotdot
p: dpco
q: dqco
r. drdot
s: dsco
S: dscapco
t. dtdotm
t: dtco
T. dtcapdot
u: duco
x: dxco
)


q=: (3 : 'y,.(local_dict > y)') "1 each 0}"1  each ' ' cut each j
(157 4 $ ,> "1 q) writecsv 'vocab.csv'

NB. also manually remove blanks

NB. local_dict '='