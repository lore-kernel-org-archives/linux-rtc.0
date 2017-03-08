Return-Path: <rtc-linux+bncBAABBMEQQDDAKGQE2YBZSTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-by2nam03on0086.outbound.protection.outlook.com. [104.47.42.86])
        by gmr-mx.google.com with ESMTPS id 2si567589pfz.1.2017.03.08.05.33.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 05:33:35 -0800 (PST)
From: "Hadimani, Jagadish" <Jagadish.Hadimani@amd.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
	"a.zummo@towertech.it" <a.zummo@towertech.it>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: Kernel without RTC
Date: Wed, 8 Mar 2017 13:33:33 +0000
Message-ID: <016032B5-A966-48A9-B60D-AD75B8B857EE@amd.com>
References: <221f9318-749f-03b8-aac8-85e9f9bec318@amd.com>,<20170308131730.zrznsnk5oldfuoib@piout.net>
In-Reply-To: <20170308131730.zrznsnk5oldfuoib@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

I guess the Linux kernel uses HPET timer...
But can we can force Linux kernel to use Tsc or per core timer...

Sent from my iPhone

> On 8 Mar 2017, at 6:47 PM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> Hi,
> 
>> On 07/03/2017 at 00:48:18 +0530, Shah, Nehal-bakulchandra wrote:
>> Hi,
>> 
>> Currently we are having hardware which does not have RTC. It is single processor system. However it does have TSC timer.
>> 
>> Now, how to use scheduler with only TSC as current kernel scheduler leverage the RTC for scheduling? I had seen one old patch
>> 
>> http://marc.info/?l=linux-kernel&m=112013203625990&w=2 
>> 
>> But i guess this patch was later on not taken, It will be great if you can some pointers to move forward?
>> 
> 
> The kernel doesn't use the RTC for its time source so it can
> already work without an RTC.
> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
