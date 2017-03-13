Return-Path: <rtc-linux+bncBC5NTO4QW4NBBUOBTHDAKGQEOIXLNFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com. [67.231.149.25])
        by gmr-mx.google.com with ESMTPS id u12si3060562pfd.3.2017.03.13.02.05.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 02:05:21 -0700 (PDT)
Date: Mon, 13 Mar 2017 09:06:21 +0000
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        <patches@opensource.wolfsonmicro.com>, <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-wm8350: Remove unused to_wm8350_from_rtc_dev
Message-ID: <20170313090621.GD6986@localhost.localdomain>
References: <20170311064213.30752-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170311064213.30752-1-iwamatsu@nigauri.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, Mar 11, 2017 at 03:42:13PM +0900, Nobuhiro Iwamatsu wrote:
> The to_wm8350_from_rtc_dev macro is not used by anything in the
> rtc-wm8350 driver.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
