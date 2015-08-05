Return-Path: <rtc-linux+bncBDS7HNEFSALRBZGVQWXAKGQEMAUDSJA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id hm7si187995wib.0.2015.08.04.18.46.11
        for <rtc-linux@googlegroups.com>;
        Tue, 04 Aug 2015 18:46:11 -0700 (PDT)
Date: Wed, 5 Aug 2015 03:46:11 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: implement suspend/resume
 function in rtc-mt6397 driver
Message-ID: <20150805014611.GY3486@piout.net>
References: <1438267994-13934-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1438267994-13934-1-git-send-email-henryc.chen@mediatek.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 30/07/2015 at 22:53:14 +0800, Henry Chen wrote :
> Implement the suspend/resume function in order to control rtc's irq_wake flag and handle as wakeup source.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
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
