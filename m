Return-Path: <rtc-linux+bncBAABB6MUW6VQKGQEX2STOMY@googlegroups.com>
Received: from mx5.zte.com.cn (mx5.zte.com.cn. [63.217.80.70])
        by gmr-mx.google.com with ESMTP id wh3si1408943pbc.0.2015.06.02.08.23.37
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 08:23:37 -0700 (PDT)
Received: from zte.com.cn (unknown [192.168.168.119])
	by Websense Email Security Gateway with ESMTP id 9EABBAA75FB59
	for <rtc-linux@googlegroups.com>; Tue,  2 Jun 2015 23:23:29 +0800 (CST)
In-Reply-To: <20150602102639.GC1715@piout.net>
References: <1433235862-1638-1-git-send-email-xlpang@126.com> <20150602102639.GC1715@piout.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Xunlei Pang <pang.xunlei@linaro.org>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/4] drivers/rtc/pcf8563: Replace
 deprecated rtc_time_to_tm() and rtc_tm_to_time()
MIME-Version: 1.0
Message-ID: <OFC9CF9873.31308A95-ON48257E58.0053C0BA-C8257E58.00548ECE@zte.com.cn>
From: pang.xunlei@zte.com.cn
Date: Wed, 3 Jun 2015 00:23:40 +0900
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote 2015-06-02=
=20
PM 06:26:39:
> Re: [PATCH v2 1/4] drivers/rtc/pcf8563: Replace deprecated=20
> rtc_time_to_tm() and rtc_tm_to_time()
>=20
> Xunlei,
>=20
> Could you please include a cover letter describing what you are trying
> to achieve when sending your series?
>=20
> You have lot of pending patches (27 in patchwork right now) and until
> now, I've pushed back on the reviews because it is really really a pain
> to follow what you are sending, resending and dropping.
>=20
> Also, for some series, you sent multiple v2 in a 3 days interval.

Apologies for the spamming, please ignore all those former 27 pending=20
patches.

I'll re-organize them with a cover letter, will resend them as new ones=20
tomorrow.

Regards,
-Xunlei
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.
--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (an=
d any attachment transmitted herewith) is privileged and confidential and i=
s intended for the exclusive use of the addressee(s).  If you are not an in=
tended recipient, any disclosure, reproduction, distribution or other disse=
mination or use of the information contained is strictly prohibited.  If yo=
u have received this mail in error, please delete it and notify us immediat=
ely.

--=20
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
