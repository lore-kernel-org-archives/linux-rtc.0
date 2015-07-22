Return-Path: <rtc-linux+bncBDS7HNEFSALRBOM5X6WQKGQEIGO7DWY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v8si744884wiw.1.2015.07.22.10.11.20
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Jul 2015 10:11:20 -0700 (PDT)
Date: Wed, 22 Jul 2015 19:11:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
	Michael Neuling <mikey@neuling.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc/rtc-opal: Enable alarms only when opal
 supports tpo
Message-ID: <20150722171119.GJ2853@piout.net>
References: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 14/07/2015 at 13:28:28 +0530, Vaibhav Jain wrote :
> rtc-opal driver provides support for rtc alarms via
> timed-power-on(tpo). However some Power platforms like BML use a fake
> rtc clock and don't support tpo. Such platforms are indicated by the
> missing 'has-tpo' property in the device tree.
> 
> Current implementation however enables callback for
> rtc_class_ops.read/set alarm irrespective of the tpo support from the
> platform. This results in a failed opal call when kernel tries to read
> an existing alarms via opal_get_tpo_time during rtc device registration.
> 
> This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
> callback pointers only when tpo is supported.
> 
> Acked-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/rtc/rtc-opal.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
Applied, thanks.

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
