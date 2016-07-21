Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBJW3YK6AKGQEIG4W3ZQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o85si178772wme.0.2016.07.21.04.10.30
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Jul 2016 04:10:30 -0700 (PDT)
Date: Thu, 21 Jul 2016 13:10:08 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit@wsystem.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: =?UTF-8?Q?=5Brtc=2Dlinux=5D_Re=3A_=5BPATCH_4=2F6=5D_rtc=3A_rv8803=3A_Always_appl?=
	=?UTF-8?Q?y_the_I=C2=B2C_workaround?=
Message-ID: <20160721111008.GE4446@piout.net>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com>
 <1469097692-103146-4-git-send-email-benoit@wsystem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1469097692-103146-4-git-send-email-benoit@wsystem.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/07/2016 at 12:41:30 +0200, Beno=C3=AEt Th=C3=A9baudeau wrote :
> The I=C2=B2C NACK issue of the RV-8803 may occur after any I=C2=B2C START
> condition, depending on the timings. Consequently, the workaround must
> be applied for all the I=C2=B2C transfers.
>=20
> This commit abstracts the I=C2=B2C transfer code into register access
> functions. This avoids duplicating the I=C2=B2C workaround everywhere. Th=
is
> also avoids the duplication of the code handling the return value of
> i2c_smbus_read_i2c_block_data(). Error messages are issued in case of
> definitive register access failures (if the workaround fails). This
> change also makes the I=C2=B2C transfer return value checks consistent.
>=20

Well, my initial idea was that the workaround is actually needed only
for operations that are not restartable from userspace.

Did you it that bug? On which RTC?

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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
