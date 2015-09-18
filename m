Return-Path: <rtc-linux+bncBCZ5JMGKVMKBB6E352XQKGQEGPV4IFQ@googlegroups.com>
Date: Thu, 17 Sep 2015 21:07:19 -0700 (PDT)
From: Hao Nguyen <conghaobk@gmail.com>
To: rtc-linux <rtc-linux@googlegroups.com>
Message-Id: <e108d983-f05c-409a-9f98-e86487e6099f@googlegroups.com>
Subject: [rtc-linux] Synchronization system time to rtc in Linux
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1782_502625184.1442549239497"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_1782_502625184.1442549239497
Content-Type: multipart/alternative;
	boundary="----=_Part_1783_619493795.1442549239503"

------=_Part_1783_619493795.1442549239503
Content-Type: text/plain; charset=UTF-8

Hi everyone,
We're working on our custom board running Linux kernel v2.6.37.

Our board uses CBC34803 chip cho real time function. Everything is ok 
except a problem.
The problem is when i change system time using "date" command with option 
'-s', time doesn't automatically update to RTC CBC34803.
My question:  which is responsible for update system time to rtc whenever 
the system time changes?
Thanks you for your reading, hope to hear some answer!!

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_1783_619493795.1442549239503
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi everyone,<div>We&#39;re working on our custom board run=
ning Linux kernel v2.6.37.</div><div><br></div><div>Our board uses CBC34803=
 chip cho real time function. Everything is ok except a problem.</div><div>=
The problem is when i change system time using &quot;date&quot; command wit=
h option &#39;-s&#39;, time doesn&#39;t automatically update to RTC CBC3480=
3.</div><div>My question: =C2=A0which is responsible for update system time=
 to rtc whenever the system time changes?</div><div>Thanks you for your rea=
ding, hope to hear some answer!!</div><div><br></div></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_1783_619493795.1442549239503--

------=_Part_1782_502625184.1442549239497--
