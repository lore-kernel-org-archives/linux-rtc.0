Return-Path: <rtc-linux+bncBD7N3SEV2QCRBNNN4S7AKGQEKB2G3HY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp2.megiteam.pl (smtp2.megiteam.pl. [213.189.52.193])
        by gmr-mx.google.com with ESMTPS id a126si196884wmd.1.2016.09.14.02.21.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Sep 2016 02:21:57 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v5] rtc: omap: Support ext_wakeup configuration
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <201609082240.a4dMqCnB%fengguang.wu@intel.com>
 <4512fa0b-890b-0f10-00dd-188fcc98fb5c@grinn-global.com>
 <20160913215837.xstx4c6d4pr42hgh@piout.net>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>, Keerthy <j-keerthy@ti.com>,
 Pawel Moll <pawel.moll@arm.com>, Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org
From: Marcin Niestroj <m.niestroj@grinn-global.com>
Message-ID: <eb67e85b-4651-33e0-abb7-339d83f36463@grinn-global.com>
Date: Wed, 14 Sep 2016 11:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <20160913215837.xstx4c6d4pr42hgh@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 13.09.2016 23:58, Alexandre Belloni wrote:
> Hi,
>
> On 12/09/2016 at 11:01:05 +0200, Marcin Niestroj wrote :
>> I guess we are missing PINCTRL in Kconfig. I didn't add that before,
>> because I thought that there is a dependency chain GENERIC_PINCONF ->
>> PINCONF -> PINCTRL.
>>
>> So to resolve this issue:
>> 1) Should we add "select" or "depends on" for PINCTRL?
>> 2) Should this option be somehow related to COMPILE_TEST?
>>
>
> Adding a "depends on PINCTRL" line should be enough to solve that issue.
>

Ok, will add that together with "depends on OF", as I noticed it is
also needed.


But right now we will not be able to compile this driver with
COMPILE_TEST, unless we select some architecture that selects PINCTRL.

So maybe it is a good idea to change "config PINCTRL" option from
'bool' to 'bool "Support PINCTRL" if COMPILE_TEST', so we can enable it
manually?

-- 
Marcin Niestroj

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
