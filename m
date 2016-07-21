Return-Path: <rtc-linux+bncBDSJR27JS4DBBWFJYS6AKGQEBK567LI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hostingsmtp.register.it (hostingsmtp71.register.it. [81.88.56.31])
        by gmr-mx.google.com with ESMTPS id y7si299940wmd.0.2016.07.21.11.30.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 11:30:47 -0700 (PDT)
Date: Thu, 21 Jul 2016 20:30:46 +0200 (CEST)
From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>
Reply-To: rtc-linux@googlegroups.com
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	rtc-linux <rtc-linux@googlegroups.com>
Message-ID: <664693872.422612.1469125846237.JavaMail.open-xchange@popperamen03.register.it>
In-Reply-To: <20160721111008.GE4446@piout.net>
References: <1469097692-103146-1-git-send-email-benoit@wsystem.com> <1469097692-103146-4-git-send-email-benoit@wsystem.com> <20160721111008.GE4446@piout.net>
Subject: =?UTF-8?Q?=5Brtc=2Dlinux=5D_Re=3A_=5BPATCH_4=2F6=5D_rtc=3A_rv8803=3A_Always_appl?=
	=?UTF-8?Q?y_the_I=C2=B2C_workaround?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/07/2016 at 14:34, Beno=C3=AEt Th=C3=A9baudeau wrote:
> On 21/07/2016 at 13:10, Alexandre Belloni wrote:
>> On 21/07/2016 at 12:41:30 +0200, Beno=C3=AEt Th=C3=A9baudeau wrote :
>>> The I=C2=B2C NACK issue of the RV-8803 may occur after any I=C2=B2C STA=
RT
>>> condition, depending on the timings. Consequently, the workaround must
>>> be applied for all the I=C2=B2C transfers.
>>>
>>> This commit abstracts the I=C2=B2C transfer code into register access
>>> functions. This avoids duplicating the I=C2=B2C workaround everywhere. =
This
>>> also avoids the duplication of the code handling the return value of
>>> i2c_smbus_read_i2c_block_data(). Error messages are issued in case of
>>> definitive register access failures (if the workaround fails). This
>>> change also makes the I=C2=B2C transfer return value checks consistent.
>>>
>>
>> Well, my initial idea was that the workaround is actually needed only
>> for operations that are not restartable from userspace.
>>
>> Did you it that bug? On which RTC?
>
> No, I've not seen that bug. However, the errata sheet says that this issu=
e may
> occur if two consecutive I=C2=B2C START conditions are slightly more than=
 950 ms
> apart. It does not even say that this is restricted to I=C2=B2C transfers
> addressing
> this RTC. Moreover, if the time is read or set from userspace, this might
> occur
> at any time relatively to an RTC interrupt or to a previous time read/set
> operation, so possibly 950 ms afterwards.
>
> All in all, it's safer and easier to always apply this workaround, all th=
e
> more
> it is applied at almost no cost when there is no issue.

To fully answer your questions, it's the job of the driver to execute the
userspace requests properly without returning spurious errors. Userspace mi=
ght
consider that such errors are definitive and that there is no reason to try=
 and
restart the operation, which could cause all sorts of issues. In other word=
s,
the driver should not rely on userspace operation restarts as a kind of
workaround if it can easily handle this itself.

Also, the kernel itself (not only userspace) may read the RTC time (with
CONFIG_RTC_HCTOSYS), without userspace caring.

I'm rather working with the RX8900.

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
