Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBKOHTTAAKGQEI7ZEN3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id 17si143312wmu.0.2016.10.19.00.41.29
        for <rtc-linux@googlegroups.com>;
        Wed, 19 Oct 2016 00:41:29 -0700 (PDT)
Date: Wed, 19 Oct 2016 09:41:18 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3] rtc-cmos: Reject unsupported alarm values
Message-ID: <20161019074118.zyqgfa672wkvl7dm@piout.net>
References: <20160902195516.7068-1-gabriele.mzt@gmail.com>
 <20161003225028.3529-1-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161003225028.3529-1-gabriele.mzt@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 04/10/2016 at 00:50:28 +0200, Gabriele Mazzotta wrote :
> Some platforms allows to specify the month and day of the month in
> which an alarm should go off, some others the day of the month and
> some others just the time.
> 
> Currently any given value is accepted by the driver and only the
> supported fields are used to program the hardware. As consequence,
> alarms are potentially programmed to go off in the wrong moment.
> 
> Fix this by rejecting any unsupported value.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/rtc/rtc-cmos.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 

Applied, thanks.

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
