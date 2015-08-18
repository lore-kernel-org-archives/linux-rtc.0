Return-Path: <rtc-linux+bncBD66BCOYSQBBBRXFZOXAKGQE66Q47WQ@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id i10si1025738igh.3.2015.08.18.01.54.30
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Aug 2015 01:54:30 -0700 (PDT)
Message-ID: <55D2F2BE.6050406@ti.com>
Date: Tue, 18 Aug 2015 14:24:22 +0530
From: Keerthy <a0393675@ti.com>
MIME-Version: 1.0
To: Johan Hovold <johan@kernel.org>, Keerthy <j-keerthy@ti.com>
CC: <alexandre.belloni@free-electrons.com>, <tony@atomide.com>,
        <linux-omap@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <grygorii.strashko@ti.com>
Subject: [rtc-linux] Re: [PATCH v4 0/2]  ARM: AM437X: Add rtc clock handling
References: <1439887411-15576-1-git-send-email-j-keerthy@ti.com> <20150818085213.GA14209@localhost>
In-Reply-To: <20150818085213.GA14209@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>



On Tuesday 18 August 2015 02:22 PM, Johan Hovold wrote:
> On Tue, Aug 18, 2015 at 02:13:28PM +0530, Keerthy wrote:
>> The series is applicable for all am437x series of processors.
>> It adds clock handling support. Boot tested on am437x-gp-evm.
>>
>> Keerthy (2):
>>    ARM: dts: AM437x: Add the internal and external clock nodes for rtc
>>    rtc: omap: Add external clock enabling support
>
> Obsolete (2-patch) cover letter?

oops yes!

>
> Either way, you should update the rtc-omap binding documentation with
> the optional clocks as well.

Thanks yes. I shall update that as well in the next version.

>
> Thanks,
> Johan
>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
