Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYMWVTDAKGQEEBEKIKA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id n128si18876wmf.2.2017.03.16.15.02.08
        for <rtc-linux@googlegroups.com>;
        Thu, 16 Mar 2017 15:02:08 -0700 (PDT)
Date: Thu, 16 Mar 2017 23:01:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Sebastian Reichel <sre@kernel.org>, rtc-linux@googlegroups.com,
	kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: cpcap: kfreeing devm allocated memory
Message-ID: <20170316220158.c3e2l6gv3jrplsbx@piout.net>
References: <20170314075319.GB6111@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170314075319.GB6111@mwanda>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/03/2017 at 10:56:30 +0300, Dan Carpenter wrote:
> We shouldn't kfree(rtc) because is devm_ managed memory.  It leads to a
> double free.
> 
> Fixes: dd3bf50b35e3 ("rtc: cpcap: new rtc driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
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
