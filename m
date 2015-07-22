Return-Path: <rtc-linux+bncBDS7HNEFSALRBYUFYCWQKGQEC4XCWHI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si145856wib.2.2015.07.22.13.53.53
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Jul 2015 13:53:53 -0700 (PDT)
Date: Wed, 22 Jul 2015 22:53:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 4/4] RTC: switch to using is_visible() to
 control sysfs attributes
Message-ID: <20150722205352.GO2853@piout.net>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
 <1437433372-15425-4-git-send-email-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437433372-15425-4-git-send-email-dmitry.torokhov@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

Seems mostly good, a few comments on top of Krzysztof's below:

On 20/07/2015 at 16:02:52 -0700, Dmitry Torokhov wrote :
> Instead of creating an attribute manually, after the device has been
> registered, let's rely on facilities provided by the attribute groups to
> control which attributes are visible and which are not. This allows to to
too many 'to' here  --------------------------------------------------^

[...]

> -void __init rtc_sysfs_init(struct class *rtc_class)
> +const struct attribute_group** rtc_get_dev_attribute_groups(void)
That space is not properly placed ^, this should be:
const struct attribute_group **rtc_get_dev_attribute_groups(void)


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
