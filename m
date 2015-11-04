Return-Path: <rtc-linux+bncBAABBCG25CYQKGQE35ZJVIQ@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1bon0072.outbound.protection.outlook.com. [157.56.111.72])
        by gmr-mx.google.com with ESMTPS id q68si126338ywf.0.2015.11.04.08.06.31
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 08:06:31 -0800 (PST)
Date: Wed, 4 Nov 2015 08:06:28 -0800
From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: Group Kconfig entries by vendor
Message-ID: <20151104160628.GH6436@xsjsorenbubuntu>
References: <1446621226-28429-1-git-send-email-soren.brinkmann@xilinx.com>
 <20151104092529.GX22331@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151104092529.GX22331@piout.net>
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

On Wed, 2015-11-04 at 10:25AM +0100, Alexandre Belloni wrote:
> On 03/11/2015 at 23:13:46 -0800, Soren Brinkmann wrote :
> > The RTC entries are mostly grouped by vendor. Move the few outliers in
> > place.
> > Also, change the one occurrence of 'nxp' to 'NXP' to make all NXP
> > entries consistent.
> >=20
>=20
> Yeah, I've been contemplating reordering the Kconfig, the main issue
> being that Philips and NXP is the same entity. And also, we have RTCs
> manufactured by different vendors that use the same chip
> (Abracon/Epson/Philips/Microcrystal) so I'm not sure what is clearer for
> the end user :)

Yeah, I wasn't sure if this is wanted or how far to go. It was mainly
triggered by the NXP devices that weren't grouped and differed in
capitalization. From there I took it a little further. Just let met know if
you want this somewhat different or not at all. It's just a suggestion
and I find it helpful if things are somewhat ordered (I was thinking go
full alphabetical sorting but didn't want to go that far without another
opinion). But I'm fine either way.

	Thanks,
	S=C3=B6ren

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
