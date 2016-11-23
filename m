Return-Path: <rtc-linux+bncBDL53MW2W4EBB4FT2XAQKGQEKAPBU7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-x22e.google.com (mail-io0-x22e.google.com. [2607:f8b0:4001:c06::22e])
        by gmr-mx.google.com with ESMTPS id 82si163513itf.0.2016.11.23.00.57.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2016 00:57:20 -0800 (PST)
Received: by mail-io0-x22e.google.com with SMTP id j65so11407629iof.0
        for <rtc-linux@googlegroups.com>; Wed, 23 Nov 2016 00:57:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161123084657.or53k7tlyjxcmrr2@piout.net>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
 <1478945246-32056-2-git-send-email-Nicolae_Rosia@mentor.com>
 <20161122223103.qd44b3z5aj4ahroi@piout.net> <CAKP5S=0vLb+7az4aaFyPjGSEE5cG+epM2qpGP=zpzhvt6x69qA@mail.gmail.com>
 <20161123084657.or53k7tlyjxcmrr2@piout.net>
From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Date: Wed, 23 Nov 2016 10:57:19 +0200
Message-ID: <CAKP5S=1GXx5PMxo-Ns82FyzJQw1MCESZr051VdsCO5DUifV+QA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: rtc-twl: kill static variables
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On Wed, Nov 23, 2016 at 10:46 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
>> Ok, could you please indicate which lines so I can fix them instead of
>> wasting your time?
>>
>
> checkpatch.pl --strict will find them for you
Thanks, I had the wrong tab setting.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
