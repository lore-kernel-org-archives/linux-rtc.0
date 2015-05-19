Return-Path: <rtc-linux+bncBDS7HNEFSALRB77J52VAKGQEW3B4Z2A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si30290wiz.0.2015.05.19.15.11.11
        for <rtc-linux@googlegroups.com>;
        Tue, 19 May 2015 15:11:11 -0700 (PDT)
Date: Wed, 20 May 2015 00:11:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-kernel@vger.kernel.org, 'Alessandro Zummo' <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	'Igor Grinberg' <grinberg@compulab.co.il>
Subject: [rtc-linux] Re: [V2] rtc: rtc-v3020: use gpio_request_array()
Message-ID: <20150519221109.GD3338@piout.net>
References: <008a01ce10a3$02d28db0$0877a910$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <008a01ce10a3$02d28db0$0877a910$%han@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2013 at 11:19:15 +0900, Jingoo Han wrote :
> Using gpio_request_array()/gpio_free_array() can make the code
> simpler because it can set the direction and initial value
> in one shot and the for loop is unnecessary.
> 
> Also, struct v3020_gpio is removed, because the struct v3020_gpio
> is replaced with struct gpio.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - Replace gpio_request_one() with gpio_request_array()
> 
>  drivers/rtc/rtc-v3020.c |   37 ++++++++++++-------------------------
>  1 files changed, 12 insertions(+), 25 deletions(-)
> 
Applied with the change suggested by Igor, thanks.

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
