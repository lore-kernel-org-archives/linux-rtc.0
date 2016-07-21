Return-Path: <rtc-linux+bncBDSJR27JS4DBB34CYO6AKGQEDQSKGRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from authsmtp.register.it (authsmtp69.register.it. [195.110.101.53])
        by gmr-mx.google.com with ESMTPS id r197si160313wmf.2.2016.07.21.05.34.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 05:34:55 -0700 (PDT)
Subject: =?UTF-8?Q?=5Brtc=2Dlinux=5D_Re=3A_=5BPATCH_4=2F6=5D_rtc=3A_rv8803=3A_Always_appl?=
	=?UTF-8?Q?y_the_I=C2=B2C_workaround?=
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
 <1469097692-103146-4-git-send-email-benoit@wsystem.com>
 <20160721111008.GE4446@piout.net>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Alessandro Zummo <a.zummo@towertech.it>
From: =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>
Message-ID: <53845770-179d-cf6c-0391-f8bde4c8b0e3@wsystem.com>
Date: Thu, 21 Jul 2016 14:34:54 +0200
MIME-Version: 1.0
In-Reply-To: <20160721111008.GE4446@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/07/2016 at 13:10, Alexandre Belloni wrote:
> On 21/07/2016 at 12:41:30 +0200, Beno=C3=AEt Th=C3=A9baudeau wrote :
>> The I=C2=B2C NACK issue of the RV-8803 may occur after any I=C2=B2C STAR=
T
>> condition, depending on the timings. Consequently, the workaround must
>> be applied for all the I=C2=B2C transfers.
>>
>> This commit abstracts the I=C2=B2C transfer code into register access
>> functions. This avoids duplicating the I=C2=B2C workaround everywhere. T=
his
>> also avoids the duplication of the code handling the return value of
>> i2c_smbus_read_i2c_block_data(). Error messages are issued in case of
>> definitive register access failures (if the workaround fails). This
>> change also makes the I=C2=B2C transfer return value checks consistent.
>>
>=20
> Well, my initial idea was that the workaround is actually needed only
> for operations that are not restartable from userspace.
>=20
> Did you it that bug? On which RTC?

No, I've not seen that bug. However, the errata sheet says that this issue =
may
occur if two consecutive I=C2=B2C START conditions are slightly more than 9=
50 ms
apart. It does not even say that this is restricted to I=C2=B2C transfers a=
ddressing
this RTC. Moreover, if the time is read or set from userspace, this might o=
ccur
at any time relatively to an RTC interrupt or to a previous time read/set
operation, so possibly 950 ms afterwards.

All in all, it's safer and easier to always apply this workaround, all the =
more
it is applied at almost no cost when there is no issue.

Best regards,
Beno=C3=AEt

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
