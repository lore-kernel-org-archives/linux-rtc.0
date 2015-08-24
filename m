Return-Path: <rtc-linux+bncBD3M5JPEVAFRB26C5OXAKGQEVVNU2DI@googlegroups.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0091.outbound.protection.outlook.com. [207.46.100.91])
        by gmr-mx.google.com with ESMTPS id v78si2368315ywe.1.2015.08.24.02.18.34
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Aug 2015 02:18:35 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Michal Simek
	<michal.simek@xilinx.com>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net> <55DACC5A.80707@xilinx.com>
 <20150824080800.GG13155@piout.net>
CC: Suneel Garapati <suneel.garapati@xilinx.com>,
	<rtc-linux@googlegroups.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <sorenb@xilinx.com>, Alessandro Zummo
	<a.zummo@towertech.it>, <punnaia@xilinx.com>, <anuragku@xilinx.com>,
	<anirudh@xilinx.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <55DAE15B.6090602@xilinx.com>
Date: Mon, 24 Aug 2015 11:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20150824080800.GG13155@piout.net>
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

Hi,

On 08/24/2015 10:08 AM, Alexandre Belloni wrote:
> On 24/08/2015 at 09:48:42 +0200, Michal Simek wrote :
>> On 08/24/2015 09:43 AM, Alexandre Belloni wrote:
>>> On 19/08/2015 at 15:23:22 +0530, Suneel Garapati wrote :
>>>> adds support for RTC controller found on
>>>> Xilinx Zynq Ultrascale+ MPSoC platform.
>>>>
>>>> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
>>>> ---
>>>> Changes v3=20
>>>> - fix checkpatch errors=20
>>>> - check time in secs arg against max sec val=20
>>>> - order header files=20
>>>> - use ptr_err_or_zero macro=20
>>>> - use time64 variants=20
>>>> Changes v2=20
>>>> - change alm to alarm=20
>>>> ---
>>>>  drivers/rtc/Kconfig      |   7 ++
>>>>  drivers/rtc/Makefile     |   1 +
>>>>  drivers/rtc/rtc-zynqmp.c | 279 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>>  3 files changed, 287 insertions(+)
>>>>  create mode 100644 drivers/rtc/rtc-zynqmp.c
>>>>
>>> Applied, thanks.
>>>
>>
>=20
> Actually, I got the following message:
> A message that you sent could not be delivered to one or more of its
> recipients. This is a permanent error. The following address(es) failed:
>=20
>   suneel.garapati@xilinx.com
>     Unknown User
>=20
> I'm not fond of carrying patches with uncontactable authors. Is that a
> permanent error?

Unfortunately. That guy left Xilinx last week but don't be scared that
none will be responsible about this driver. I have well proven history
on Linux and others project and I am here if you need to do some testing
or ACK for changes. Just let me know when you need something.

get_maintainer returns me and Soren that's why you shouldn't have any
problem with it.

[linux]$ ./scripts/get_maintainer.pl -f drivers/rtc/rtc-zynqmp.c
Alessandro Zummo <a.zummo@towertech.it> (maintainer:REAL TIME CLOCK
(RTC) SUBSYSTEM)
Alexandre Belloni <alexandre.belloni@free-electrons.com>
(maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
"S=C3=B6ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer)
rtc-linux@googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE)
linux-kernel@vger.kernel.org (open list)

Thanks,
Michal

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
