Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSX2W7FAKGQEEUVVYXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 197si1709349wmo.0.2017.06.23.22.48.58
        for <rtc-linux@googlegroups.com>;
        Fri, 23 Jun 2017 22:48:58 -0700 (PDT)
Date: Sat, 24 Jun 2017 07:48:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>
Subject: [rtc-linux] Re: [PATCH] rtc: opal: Implement rtc_class_ops.alarm_irq_enable
 callback
Message-ID: <20170624054849.e2dkt55hjaufisf2@piout.net>
References: <20170531130901.31415-1-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170531130901.31415-1-vaibhav@linux.vnet.ibm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/05/2017 at 18:39:01 +0530, Vaibhav Jain wrote:
> Provide an implementation of the callback
> rtc_class_ops.alarm_irq_enable for rtc-opal driver. This callback is
> called when the wake alarm is disabled via the command:
> 
> 'echo 0 > /sys/class/rtc/rtc0/wakealarm'
> 
> Without this the Timed-Power-On(TPO) config remains set even when its
> disabled by the above command and FSP will still force machine
> boot at previously configured alarm time.
> 
> The callback is implemented as function opal_tpo_alarm_irq_enable()
> which calls opal_set_tpo_time() with alarm.enabled == 0. A branch is
> added to opal_set_tpo_time() to handle this case by passing y_m_d ==
> h_m_s_ms == 0 to opal as arguments for opal_tpo_write() call.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/rtc/rtc-opal.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
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
