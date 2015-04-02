Return-Path: <rtc-linux+bncBDS7HNEFSALRBOXY6SUAKGQE7XL6ZLY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id na10si310635wic.0.2015.04.02.05.55.21
        for <rtc-linux@googlegroups.com>;
        Thu, 02 Apr 2015 05:55:21 -0700 (PDT)
Date: Thu, 2 Apr 2015 14:55:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, t-kristo@ti.com,
	nsekhar@ti.com, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 1/3] rtc: omap: Unlock and Lock rtc
 registers before and after register writes
Message-ID: <20150402125520.GI20669@piout.net>
References: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
 <1427972951-18959-2-git-send-email-lokeshvutla@ti.com>
 <20150402123344.GH20669@piout.net>
 <551D399B.5050609@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <551D399B.5050609@ti.com>
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

On 02/04/2015 at 18:14:11 +0530, Lokesh Vutla wrote :
> Here is the updated patch.
> 

You should probably send it properly using git send-email, have a look
at the --in-reply-to parameter, else, I'm not sure Andrew will be able
to pick it up.

Thanks!

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
