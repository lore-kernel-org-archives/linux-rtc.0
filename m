Return-Path: <rtc-linux+bncBDEKVJM7XAHRBC4LQW4QKGQEOSBX3OA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id c69si535134wme.2.2016.04.27.16.04.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 16:04:43 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arch@vger.kernel.org, a.zummo@towertech.it, dalias@libc.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v3 09/16] rtc: m68k: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 01:04:23 +0200
Message-ID: <4642144.cyaFZ6JYuF@wuerfel>
In-Reply-To: <1461796470-1291527-10-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de> <1461796470-1291527-10-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thursday 28 April 2016 00:34:23 Arnd Bergmann wrote:
>                 return -ENODEV;
>  
> -       pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +       /* or just call devm_rtc_device_register instead? */

Oops, I was planning to remove the comment here.

I probably have to do a v4 anyway, fixed it up locally now.

	Arnd

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
