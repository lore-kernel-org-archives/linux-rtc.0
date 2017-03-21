Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBW7FYXDAKGQEJLODYUA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e72si1309249wma.0.2017.03.21.11.37.15
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Mar 2017 11:37:15 -0700 (PDT)
Date: Tue, 21 Mar 2017 19:37:14 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Tracy Smith <tlsmith3777@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: Question: Linux changes required for off control
 board RTC
Message-ID: <20170321183714.dcdhcqjbuexuqh4p@piout.net>
References: <CAChUvXMxreofSQqsv-+Pgq9uZPpJ24P0geUYes_6Lu8nCtsNGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAChUvXMxreofSQqsv-+Pgq9uZPpJ24P0geUYes_6Lu8nCtsNGg@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 21/03/2017 at 13:08:54 -0500, Tracy Smith wrote:
> Hi, not sure if this is the correct venue to post a question, so
> please forgive and direct me to the correct board or list if not.
> 

Lee is probably not the one to ask :)

> A custom board implementation using a ARM-8 Cortex A53 NXP LS1043ardb
> is considering moving the RTC from the control board to an FPGA.
> Reason is for accuracy of time/date and efficiency for their FPGA/DSP
> application.
> 
> 1) What kernel changes would be required to support such an
> implementation and these would need to be pushed to the community
> under the GPL?
> 

You'll have to write a proper driver. It will have to be licensed under
the GPLv2 but you don't necessarily have to push it anywhere (that is
not how the GPL is working).

> 2) Is it a trivial task to make such changes in the kernel to support
> an RTC not located on the control board/SoC itself?
> 

RTC drivers are not so complicated. I'd say that the difficulty mainly
depends on how the SoC can access the FPGA.


> 3) What is the expected behavior of the kernel with no changes added
> to accommodate such an architecture?
> 

The kernel will work, the RTC is not required.

> 4) Is there a configurable kernel option to allow for such a change,
> or have these or similar changes already been added to the kernel?
> 

More details are needed to answer that but basically if your FPGa
emulates an RTC that is already supported, you don't need to write
much.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
