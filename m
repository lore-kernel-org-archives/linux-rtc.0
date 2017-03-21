Return-Path: <rtc-linux+bncBDVNLUMXTUCRBMGWYXDAKGQE57GMSYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x234.google.com (mail-lf0-x234.google.com. [2a00:1450:4010:c07::234])
        by gmr-mx.google.com with ESMTPS id p144si1256349wme.2.2017.03.21.11.04.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2017 11:04:32 -0700 (PDT)
Received: by mail-lf0-x234.google.com with SMTP id y193so70058467lfd.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Mar 2017 11:04:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314135932.ngn7uh67duzroy47@dell>
References: <20170214221529.6434-1-enric.balletbo@collabora.com>
 <20170214221529.6434-4-enric.balletbo@collabora.com> <20170314135932.ngn7uh67duzroy47@dell>
From: Tracy Smith <tlsmith3777@gmail.com>
Date: Tue, 21 Mar 2017 13:04:31 -0500
Message-ID: <CAChUvXOmOypRZJSWHVN29W0AipeFfhrD40NzuVNU4kOkohjM9Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
To: Lee Jones <lee.jones@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	lkml <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: multipart/alternative; boundary=001a1140178cca04ff054b417925
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--001a1140178cca04ff054b417925
Content-Type: text/plain; charset=UTF-8

Hi, not sure if this is the correct venue to post a question, so please
forgive and direct me to the correct board or list if not.

A custom board implementation using a ARM-8 Cortex A53 NXP LS1043ardb is
considering moving the RTC from the control board to an FPGA.  Reason is
for accuracy of time/date and efficiency for their FPGA/DSP application.

1) What kernel changes would be required to support such an implementation
and these would need to be pushed to the community under the GPL?

2) Is it a trivial task to make such changes in the kernel to support an
RTC not located on the control board/SoC itself?

3) What is the expected behavior of the kernel with no changes added to
accommodate such an architecture?

4) Is there a configurable kernel option to allow for such a change, or
have these or similar changes already been added to the kernel?

thx,
Tracy

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--001a1140178cca04ff054b417925
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, not sure if this is the correct venue to post a q=
uestion, so please forgive and direct me to the correct board or list if no=
t.</div><div><br></div><div>A custom board implementation using a ARM-8 Cor=
tex A53 NXP LS1043ardb=C2=A0is considering moving the RTC from the control =
board to an FPGA.=C2=A0 Reason is for accuracy of time/date and efficiency =
for their FPGA/DSP application.</div><div><br></div><div>1) What kernel cha=
nges would be required to support such an implementation and these would ne=
ed to be pushed to the community under the GPL? </div><div><br></div><div>2=
) Is it a trivial task to make such changes in the kernel to support an RTC=
 not located on the control board/SoC itself?</div><div><br></div><div>3) W=
hat is the expected behavior of the kernel with no changes added to accommo=
date such an architecture?</div><div><br></div><div>4) Is there a configura=
ble kernel option to allow for such a change, or have these or similar chan=
ges already been added to the kernel?</div><div><br></div><div>thx,</div><d=
iv>Tracy</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><br=
></div>
</div></div>

<p></p>

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

--001a1140178cca04ff054b417925--
