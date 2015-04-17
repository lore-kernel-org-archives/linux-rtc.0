Return-Path: <rtc-linux+bncBDJMJGESWAMRBDEOYSUQKGQENALV3PQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k2si114823wif.0.2015.04.17.06.13.48
        for <rtc-linux@googlegroups.com>;
        Fri, 17 Apr 2015 06:13:48 -0700 (PDT)
Message-ID: <5531070A.7080105@free-electrons.com>
Date: Fri, 17 Apr 2015 15:13:46 +0200
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Andrew Lunn <andrew@lunn.ch>
CC: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com, Arnaud Ebalard <arno@natisbad.org>,
 Jason Cooper <jason@lakedaemon.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>,
 Tawfik Bayouk <tawfik@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>, stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: Fix concurrency access in armada38x_rtc_set_time
References: <1429103633-24376-1-git-send-email-gregory.clement@free-electrons.com> <20150415192732.GB13105@lunn.ch>
In-Reply-To: <20150415192732.GB13105@lunn.ch>
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

Hi Andrew,

On 15/04/2015 21:27, Andrew Lunn wrote:
> On Wed, Apr 15, 2015 at 03:13:53PM +0200, Gregory CLEMENT wrote:
>> While setting the time, the RTC TIME register should not be
>> accessed. However due to hardware constraints, setting the RTC time
>> involves sleeping during 100ms. This sleep was done outside the
>> critical section protected by the spinlock, so it was possible to read
>> the RTC TIME register and get an incorrect value. This patch
>> introduces a mutex for protecting the RTC TIME access, unlike the
>> spinlock it is allowed to sleep in a critical section protected by a
>> mutex. The RTC STATUS register can still be used from the interrupt
>> handler but it has no effect on setting the time.
> 
> Hi Gregory
> 
> There is the following comment in the code:
> 
>         /*
>          * Setting the RTC time not always succeeds. According to the
>          * errata we need to first write on the status register and
>          * then wait for 100ms before writing to the time register to be
>          * sure that the data will be taken into account.
>          */
> 
> The interrupt handler also writes to the STATUS register. So what
> happens if there is an interrupt during that 100ms and a second write
> to STATUS?


As I wrote in the commit log, the RTC STATUS register can still be used from
the interrupt handler but it has no effect on setting the time: between writing
0 in the RTC_STATUS register and writing the time in the RTC_TIME register,
writing anything in RTC_STATUS won't prevent to write the time successfully.


> 
> Maybe it is necessary to disable the RTC interrupt while setting the
> time?

It won't be necessary.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

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
