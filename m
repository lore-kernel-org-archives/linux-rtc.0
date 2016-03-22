Return-Path: <rtc-linux+bncBDS7HNEFSALRBUMVY63QKGQE24RWODA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 71si544305wmp.0.2016.03.22.15.44.32
        for <rtc-linux@googlegroups.com>;
        Tue, 22 Mar 2016 15:44:32 -0700 (PDT)
Date: Tue, 22 Mar 2016 23:44:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mylene JOSSERAND <mylene.josserand@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/2] rtc: abx80x: Handle autocalibration and
 oscillator failure
Message-ID: <20160322224422.GA2365@piout.net>
References: <cover.1458579029.git.mylene.josserand@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <cover.1458579029.git.mylene.josserand@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/03/2016 at 18:06:08 +0100, Mylene JOSSERAND wrote :
> The current patches handle the autocalibration and the oscillator failure
> for ABX80X RTC.
> The autocalibration is handled using sysfs entries and the oscillator
> failure bit is handled only for the XT Oscillator.
> 
> Mylene JOSSERAND (2):
>   rtc: abx80x: handle autocalibration
>   rtc: abx80x: handle the oscillator failure bit
> 

Both applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
