-- hide.lat / lite / 1531496c939a
local L1OoIj=(getfenv and getfenv(1)) or _ENV or _G
local LO0Il0o0oIjIi,jooo1oo0j111=string.byte,string.char
local function LiIO0O0(iL1IoI1llil,IlloIj0OL1i)
local illllLOj=""
local jilIliOj=#IlloIj0OL1i
for iI1OOlj=1,#iL1IoI1llil do illllLOj=illllLOj..jooo1oo0j111((LO0Il0o0oIjIi(iL1IoI1llil,iI1OOlj)-LO0Il0o0oIjIi(IlloIj0OL1i,(iI1OOlj-1)%jilIliOj+1))%256) end
return illllLOj
end
local IjjOiiIiL=L1OoIj[LiIO0O0("\031 \219\173\247\210","\172\187oH\148^")]
local LO11iOojIji1=L1OoIj[LiIO0O0("\193\217\198\238\007\181","NeT\133\153")][LiIO0O0("4\188\228","\193G\130\017")]
local L0i1Lo0=L1OoIj[LiIO0O0("\028\244=4\r","\168\147\219\200")][LiIO0O0("\144B\197\003\202\197","-\211W\160iQ")]
local iLjLIl=L1OoIj[LiIO0O0("O\189\186J","\226\\F")][LiIO0O0("\155\132\205\229`","5\024^v\238")]
local j10jji0=L1OoIj[LiIO0O0("=\252 \235\171o\238;","\201\141\178v>\r\137")]
local i0j0oLoj=L1OoIj[LiIO0O0("v\017\206\199\226","\017\159\\Xp\016")]
local LjO01o00oLOi=LO0Il0o0oIjIi("`")+IjjOiiIiL("#",0,0)*22+j10jji0("3955")*7+(jooo1oo0j111(89,78)=="YN" and 4799 or 22)
local L0I1l0O11Lii=L1OoIj[LiIO0O0("O)\22474","\219\200~\203\207\157}")][LiIO0O0("\004\024\029\212","\148\183\186i\138\143")] or function(...) return {n=IjjOiiIiL("#",...),...} end
local IjOO01=L1OoIj[LiIO0O0("\242e#:*","~\004\193\206\197\236\180")][LiIO0O0("\132\031\173p\020\168","\015\177=")] or L1OoIj[LiIO0O0("\162\027}\142\016x","-\173\r")]
local jii1OLL1jjLI="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function Ij1OliOji(ll0oOi)
local lIliij0={}
for Ijoloo=1,64 do lIliij0[LO0Il0o0oIjIi(jii1OLL1jjLI,Ijoloo)]=Ijoloo-1 end
local IO1lljLOi,LlLOLOjjoOLi,IIL0oLo010l,lIOLo001L1Il={},0,0,0
for Ijoloo=1,#ll0oOi do
local ioOLjllLOjoI=lIliij0[LO0Il0o0oIjIi(ll0oOi,Ijoloo)]
if ioOLjllLOjoI then
LlLOLOjjoOLi=LlLOLOjjoOLi*64+ioOLjllLOjoI
IIL0oLo010l=IIL0oLo010l+6
if IIL0oLo010l>=8 then IIL0oLo010l=IIL0oLo010l-8 lIOLo001L1Il=lIOLo001L1Il+1 IO1lljLOi[lIOLo001L1Il]=jooo1oo0j111(iLjLIl(LlLOLOjjoOLi/(2^IIL0oLo010l))%256) LlLOLOjjoOLi=LlLOLOjjoOLi%(2^IIL0oLo010l) end
end
end
return L0i1Lo0(IO1lljLOi)
end
local Ijo1lOIlIO="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"
local function LOLjI01(LL0I1lIojjijoi)
local LLoLOLOio01i=(1078167281)+LjO01o00oLOi
local i00oLoI=107
local iLLLj1IIljIo={}
for j1i0l0o=1,#LL0I1lIojjijoi do
LLoLOLOio01i=(LLoLOLOio01i*40255+3305294365)%4294967296
local ii10oL0j01i1oL=LO0Il0o0oIjIi(LL0I1lIojjijoi,j1i0l0o)
local i0I0Ljoll=(iLjLIl(LLoLOLOio01i/65536)+i00oLoI+(j1i0l0o-1)*163)%256
iLLLj1IIljIo[j1i0l0o]=jooo1oo0j111((ii10oL0j01i1oL-i0I0Ljoll)%256)
i00oLoI=(i00oLoI*41+ii10oL0j01i1oL+1)%251
end
return L0i1Lo0(iLLLj1IIljIo)
end
local I10jOli1iIlO=LOLjI01(Ij1OliOji(Ijo1lOIlIO))
local ii10oL0j01i1oL=1
local function IlOjIiLL11O1()
local j1i0l0o=LO0Il0o0oIjIi(I10jOli1iIlO,ii10oL0j01i1oL)
ii10oL0j01i1oL=ii10oL0j01i1oL+1
return j1i0l0o
end
local function loIllLLloL()
local j1i0l0o,ij11jLLj1jL=LO0Il0o0oIjIi(I10jOli1iIlO,ii10oL0j01i1oL,ii10oL0j01i1oL+1)
ii10oL0j01i1oL=ii10oL0j01i1oL+2
return j1i0l0o+ij11jLLj1jL*256
end
local function Lojo10OLliO()
local j1i0l0o,ij11jLLj1jL,LL0I1lIojjijoi,iLLLj1IIljIo=LO0Il0o0oIjIi(I10jOli1iIlO,ii10oL0j01i1oL,ii10oL0j01i1oL+3)
ii10oL0j01i1oL=ii10oL0j01i1oL+4
return j1i0l0o+ij11jLLj1jL*256+LL0I1lIojjijoi*65536+iLLLj1IIljIo*16777216
end
local function Io1IOLL()
local j1i0l0o=Lojo10OLliO()
local ij11jLLj1jL=LO11iOojIji1(I10jOli1iIlO,ii10oL0j01i1oL,ii10oL0j01i1oL+j1i0l0o-1)
ii10oL0j01i1oL=ii10oL0j01i1oL+j1i0l0o
return ij11jLLj1jL
end
local function jiOjIOIi10I1()
local j1i0l0o=IlOjIiLL11O1()
local ij11jLLj1jL=Io1IOLL()
if j1i0l0o==0 then return j10jji0(ij11jLLj1jL)
elseif j1i0l0o==1 then return ij11jLLj1jL
elseif j1i0l0o==2 then return 1/0
elseif j1i0l0o==3 then return -1/0
else return 0/0 end
end
local function IIlliiOiL()
local L1L1looI=IlOjIiLL11O1()
local j1i0l0o=IlOjIiLL11O1()
local ij11jLLj1jL=loIllLLloL()
local Iji011I={}
for LL0I1lIojjijoi=1,ij11jLLj1jL do local IIlOlOI=loIllLLloL() Iji011I[LL0I1lIojjijoi]={IIlOlOI,Io1IOLL()} end
local iLLLj1IIljIo=Lojo10OLliO()
local llLii1iilOoOlI={}
for LL0I1lIojjijoi=1,iLLLj1IIljIo do
llLii1iilOoOlI[LL0I1lIojjijoi]={loIllLLloL(),loIllLLloL(),Lojo10OLliO(),Lojo10OLliO()}
end
local ii10oL0j01i1oL=loIllLLloL()
local lIloOooi0={}
for LL0I1lIojjijoi=1,ii10oL0j01i1oL do lIloOooi0[LL0I1lIojjijoi]=IIlliiOiL() end
local j1IL0oOloi0li0=loIllLLloL()
local IjoIlOjj={}
for LL0I1lIojjijoi=1,j1IL0oOloi0li0 do IjoIlOjj[LL0I1lIojjijoi]={IlOjIiLL11O1(),loIllLLloL()} end
return {L1L1looI,j1i0l0o,llLii1iilOoOlI,Iji011I,lIloOooi0,IjoIlOjj,{}}
end
local function Ll0iOI(ljIljl1,ioOI1i0oLoLj,IIlOlOI)
if ioOI1i0oLoLj[IIlOlOI]~=nil then return ioOI1i0oLoLj[IIlOlOI] end
local ll0oOi=ljIljl1[IIlOlOI]
local lIliij0=ll0oOi[1]
local Ijoloo=ll0oOi[2]
local IO1lljLOi=(13382+lIliij0*251+1)%65536
local LlLOLOjjoOLi={}
for IIL0oLo010l=1,#Ijoloo do
IO1lljLOi=(IO1lljLOi*40503+12345)%65536
LlLOLOjjoOLi[IIL0oLo010l]=jooo1oo0j111((LO0Il0o0oIjIi(Ijoloo,IIL0oLo010l)-iLjLIl(IO1lljLOi/256)%256-IIL0oLo010l*(13382%256))%256)
end
local lIOLo001L1Il=L0i1Lo0(LlLOLOjjoOLi)
local ioOLjllLOjoI=LO0Il0o0oIjIi(lIOLo001L1Il,1)
local L0L0io0=LO0Il0o0oIjIi(lIOLo001L1Il,2)+LO0Il0o0oIjIi(lIOLo001L1Il,3)*256+LO0Il0o0oIjIi(lIOLo001L1Il,4)*65536+LO0Il0o0oIjIi(lIOLo001L1Il,5)*16777216
local jlLO11=LO11iOojIji1(lIOLo001L1Il,6,5+L0L0io0)
local lIIiO1i0l
if ioOLjllLOjoI==0 then lIIiO1i0l=j10jji0(jlLO11) elseif ioOLjllLOjoI==1 then lIIiO1i0l=jlLO11 elseif ioOLjllLOjoI==2 then lIIiO1i0l=1/0 elseif ioOLjllLOjoI==3 then lIIiO1i0l=-1/0 else lIIiO1i0l=0/0 end
ioOI1i0oLoLj[IIlOlOI]=lIIiO1i0l
return lIIiO1i0l
end
local ioiOI11oiLIlj={}
local ji1ooIO1lI1=loIllLLloL()
for L0oioIL1oOI00=1,ji1ooIO1lI1 do local j1i0l0o=loIllLLloL() local ij11jLLj1jL=loIllLLloL() ioiOI11oiLIlj[j1i0l0o]=ij11jLLj1jL end
local l0lioO1L=IIlliiOiL()
local Ij0oj10OLOjOl
local function i00iilILI1iijO(l0lioO1L,IjoIlOjj)
return function(...) return Ij0oj10OLOjOl(l0lioO1L,IjoIlOjj,L0I1l0O11Lii(...)) end
end
Ij0oj10OLOjOl=function(l0lioO1L,IjoIlOjj,IIojIOL)
local il1ioiojOiIO={}
local lj0o1oil0IL=0
local L1L1looI=l0lioO1L[1]
local jljOiIiOlIoILl=IIojIOL.n
for j1i0l0o=1,L1L1looI do il1ioiojOiIO[j1i0l0o-1]=IIojIOL[j1i0l0o] end
local ilI0j00iiOj1i,jo0IoLLOO1oI1l={},0
if l0lioO1L[2]==1 then jo0IoLLOO1oI1l=jljOiIiOlIoILl-L1L1looI; if jo0IoLLOO1oI1l<0 then jo0IoLLOO1oI1l=0 end; for j1i0l0o=1,jo0IoLLOO1oI1l do ilI0j00iiOj1i[j1i0l0o]=IIojIOL[L1L1looI+j1i0l0o] end end
local llLii1iilOoOlI,Iji011I,lIloOooi0=l0lioO1L[3],l0lioO1L[4],l0lioO1L[5]
local LLjjijOL1Lij=l0lioO1L[7]
local L1iOl1oIi=1
local j1IL0oOloi0li0=0
while true do
local lo0lj0I=llLii1iilOoOlI[L1iOl1oIi]
L1iOl1oIi=L1iOl1oIi+1
local jljiIILo,j1i0l0o,ij11jLLj1jL,LL0I1lIojjijoi=lo0lj0I[1],lo0lj0I[2],lo0lj0I[3],lo0lj0I[4]
local iLLLj1IIljIo=ioiOI11oiLIlj[jljiIILo]
if (L1iOl1oIi*L1iOl1oIi*L1iOl1oIi-L1iOl1oIi)%6~=0 then lj0o1oil0IL=lj0o1oil0IL+2 end
if (L1iOl1oIi%2)*(L1iOl1oIi%2)-(L1iOl1oIi%2)~=0 then lj0o1oil0IL=lj0o1oil0IL+4 end
if iLLLj1IIljIo==29 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]..il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==24 then
il1ioiojOiIO[j1i0l0o+1]=il1ioiojOiIO[ij11jLLj1jL]; il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL][il1ioiojOiIO[LL0I1lIojjijoi]]
elseif iLLLj1IIljIo==7 then
for ll0oOi=j1i0l0o,j1i0l0o+ij11jLLj1jL do il1ioiojOiIO[ll0oOi]=nil end
elseif iLLLj1IIljIo==38 then
local lIliij0=il1ioiojOiIO[j1i0l0o]
local lIOLo001L1Il=il1ioiojOiIO[j1i0l0o+1]
local ioOLjllLOjoI=il1ioiojOiIO[j1i0l0o+2]
local LlLOLOjjoOLi=L0I1l0O11Lii(lIliij0(lIOLo001L1Il,ioOLjllLOjoI))
local IIL0oLo010l=LlLOLOjjoOLi[1]
if IIL0oLo010l~=nil then
il1ioiojOiIO[j1i0l0o+2]=IIL0oLo010l
for ll0oOi=1,ij11jLLj1jL do il1ioiojOiIO[j1i0l0o+3+ll0oOi-1]=LlLOLOjjoOLi[ll0oOi] end
L1iOl1oIi=LL0I1lIojjijoi+1
end
elseif iLLLj1IIljIo==15 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]^il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==18 then
IjoIlOjj[ij11jLLj1jL+1][1]=il1ioiojOiIO[j1i0l0o]
elseif iLLLj1IIljIo==17 then
il1ioiojOiIO[j1i0l0o]=L1OoIj[Ll0iOI(Iji011I,LLjjijOL1Lij,ij11jLLj1jL+1)]
elseif iLLLj1IIljIo==39 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]/il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==3 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]-il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==13 then
il1ioiojOiIO[j1i0l0o][il1ioiojOiIO[ij11jLLj1jL]]=il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==14 then
il1ioiojOiIO[j1i0l0o]=#il1ioiojOiIO[ij11jLLj1jL]
elseif iLLLj1IIljIo==34 then
il1ioiojOiIO[j1i0l0o]={il1ioiojOiIO[ij11jLLj1jL]}
elseif iLLLj1IIljIo==40 then
il1ioiojOiIO[j1i0l0o]=-il1ioiojOiIO[ij11jLLj1jL]
elseif iLLLj1IIljIo==22 then
local lIliij0=il1ioiojOiIO[j1i0l0o]
local Ijoloo
if ij11jLLj1jL==0 then Ijoloo=j1IL0oOloi0li0-j1i0l0o-1 else Ijoloo=ij11jLLj1jL-1 end
local IO1lljLOi={}
for ll0oOi=1,Ijoloo do IO1lljLOi[ll0oOi]=il1ioiojOiIO[j1i0l0o+ll0oOi] end
local LlLOLOjjoOLi=L0I1l0O11Lii(lIliij0(IjOO01(IO1lljLOi,1,Ijoloo)))
if LL0I1lIojjijoi==0 then
local IIL0oLo010l=LlLOLOjjoOLi.n
for ll0oOi=1,IIL0oLo010l do il1ioiojOiIO[j1i0l0o+ll0oOi-1]=LlLOLOjjoOLi[ll0oOi] end
j1IL0oOloi0li0=j1i0l0o+IIL0oLo010l
else
for ll0oOi=1,LL0I1lIojjijoi-1 do il1ioiojOiIO[j1i0l0o+ll0oOi-1]=LlLOLOjjoOLi[ll0oOi] end
end
elseif iLLLj1IIljIo==30 then
il1ioiojOiIO[j1i0l0o]={}
elseif iLLLj1IIljIo==27 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]<=il1ioiojOiIO[LL0I1lIojjijoi])
elseif iLLLj1IIljIo==11 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]+il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==37 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]-il1ioiojOiIO[ij11jLLj1jL]%il1ioiojOiIO[LL0I1lIojjijoi])/il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==26 then
L1OoIj[Ll0iOI(Iji011I,LLjjijOL1Lij,ij11jLLj1jL+1)]=il1ioiojOiIO[j1i0l0o]
elseif iLLLj1IIljIo==12 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]%il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==42 then
il1ioiojOiIO[j1i0l0o]=((il1ioiojOiIO[j1i0l0o] or 0)+ij11jLLj1jL)%(LL0I1lIojjijoi+1)
elseif iLLLj1IIljIo==4 then
il1ioiojOiIO[j1i0l0o]=not il1ioiojOiIO[ij11jLLj1jL]
elseif iLLLj1IIljIo==21 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]==il1ioiojOiIO[LL0I1lIojjijoi])
elseif iLLLj1IIljIo==35 then
if ij11jLLj1jL==0 then
for ll0oOi=1,jo0IoLLOO1oI1l do il1ioiojOiIO[j1i0l0o+ll0oOi-1]=ilI0j00iiOj1i[ll0oOi] end
j1IL0oOloi0li0=j1i0l0o+jo0IoLLOO1oI1l
else
for ll0oOi=1,ij11jLLj1jL-1 do il1ioiojOiIO[j1i0l0o+ll0oOi-1]=ilI0j00iiOj1i[ll0oOi] end
end
elseif iLLLj1IIljIo==33 then
local lIliij0=lIloOooi0[ij11jLLj1jL+1]
local IO1lljLOi={}
local LlLOLOjjoOLi=lIliij0[6]
for ll0oOi=1,#LlLOLOjjoOLi do
local IIL0oLo010l=LlLOLOjjoOLi[ll0oOi]
if IIL0oLo010l[1]==1 then IO1lljLOi[ll0oOi]=il1ioiojOiIO[IIL0oLo010l[2]] else IO1lljLOi[ll0oOi]=IjoIlOjj[IIL0oLo010l[2]+1] end
end
il1ioiojOiIO[j1i0l0o]=i00iilILI1iijO(lIliij0,IO1lljLOi)
elseif iLLLj1IIljIo==43 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]>il1ioiojOiIO[LL0I1lIojjijoi])
elseif iLLLj1IIljIo==5 then
L1iOl1oIi=ij11jLLj1jL+1
elseif iLLLj1IIljIo==8 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL][1]
elseif iLLLj1IIljIo==1 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]
elseif iLLLj1IIljIo==10 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]>=il1ioiojOiIO[LL0I1lIojjijoi])
elseif iLLLj1IIljIo==6 then
il1ioiojOiIO[j1i0l0o]=IjoIlOjj[ij11jLLj1jL+1][1]
elseif iLLLj1IIljIo==28 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]<il1ioiojOiIO[LL0I1lIojjijoi])
elseif iLLLj1IIljIo==25 then
il1ioiojOiIO[ij11jLLj1jL][1]=il1ioiojOiIO[j1i0l0o]
elseif iLLLj1IIljIo==19 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[j1i0l0o]+il1ioiojOiIO[j1i0l0o+2]
local lIliij0=il1ioiojOiIO[j1i0l0o+2]
if (lIliij0>0 and il1ioiojOiIO[j1i0l0o]<=il1ioiojOiIO[j1i0l0o+1]) or (lIliij0<=0 and il1ioiojOiIO[j1i0l0o]>=il1ioiojOiIO[j1i0l0o+1]) then il1ioiojOiIO[j1i0l0o+3]=il1ioiojOiIO[j1i0l0o]; L1iOl1oIi=ij11jLLj1jL+1 end
elseif iLLLj1IIljIo==2 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[j1i0l0o]-il1ioiojOiIO[j1i0l0o+2]; L1iOl1oIi=ij11jLLj1jL+1
elseif iLLLj1IIljIo==31 then
il1ioiojOiIO[j1i0l0o]=(il1ioiojOiIO[ij11jLLj1jL]~=il1ioiojOiIO[LL0I1lIojjijoi])
elseif iLLLj1IIljIo==9 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL]*il1ioiojOiIO[LL0I1lIojjijoi]
elseif iLLLj1IIljIo==32 then
local Ijoloo
if ij11jLLj1jL==0 then Ijoloo=j1IL0oOloi0li0-j1i0l0o else Ijoloo=ij11jLLj1jL-1 end
local IO1lljLOi={}
for ll0oOi=1,Ijoloo do IO1lljLOi[ll0oOi]=il1ioiojOiIO[j1i0l0o+ll0oOi-1] end
return IjOO01(IO1lljLOi,1,Ijoloo)
elseif iLLLj1IIljIo==41 then
if (not not il1ioiojOiIO[j1i0l0o])==(ij11jLLj1jL~=0) then L1iOl1oIi=LL0I1lIojjijoi+1 end
elseif iLLLj1IIljIo==23 then
il1ioiojOiIO[j1i0l0o]=Ll0iOI(Iji011I,LLjjijOL1Lij,ij11jLLj1jL+1)
elseif iLLLj1IIljIo==20 then
il1ioiojOiIO[j1i0l0o]=(ij11jLLj1jL~=0)
elseif iLLLj1IIljIo==36 then
local Ijoloo
if ij11jLLj1jL==0 then Ijoloo=j1IL0oOloi0li0-j1i0l0o-1 else Ijoloo=ij11jLLj1jL end
local lIliij0=il1ioiojOiIO[j1i0l0o]
for ll0oOi=1,Ijoloo do lIliij0[LL0I1lIojjijoi+ll0oOi]=il1ioiojOiIO[j1i0l0o+ll0oOi] end
elseif iLLLj1IIljIo==16 then
il1ioiojOiIO[j1i0l0o]=il1ioiojOiIO[ij11jLLj1jL][il1ioiojOiIO[LL0I1lIojjijoi]]
else i0j0oLoj() end
end
return lj0o1oil0IL
end
return Ij0oj10OLOjOl(l0lioO1L,{},L0I1l0O11Lii(...))
