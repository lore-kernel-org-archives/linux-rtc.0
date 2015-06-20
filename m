Return-Path: <rtc-linux+bncBD5O5IWPJMINZMUWVQCRUBAN2QX66@googlegroups.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com. [2a00:1450:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id ec7si455386wib.3.2015.06.20.09.48.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2015 09:48:28 -0700 (PDT)
Received: by mail-wi0-x22c.google.com with SMTP id nd19so42990823wic.1
        for <rtc-linux@googlegroups.com>; Sat, 20 Jun 2015 09:48:28 -0700 (PDT)
Message-ID: <55859951.5090308@gmail.com>
Date: Sat, 20 Jun 2015 18:48:17 +0200
From: Philippe Reynes <tremyfr@gmail.com>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>,
 Russell King <linux@arm.linux.org.uk>,
 rtc-linux@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [rtc-linux] Re: [PATCH v2 2/6] imx35: define two clocks for rtc
References: <1434809732-8996-1-git-send-email-tremyfr@gmail.com> <1434809732-8996-3-git-send-email-tremyfr@gmail.com> <CAOMZO5DOC2WXAVLxv_srHAZVAtnhTaP1yqYL9iQvJivKHRj1jA@mail.gmail.com>
In-Reply-To: <CAOMZO5DOC2WXAVLxv_srHAZVAtnhTaP1yqYL9iQvJivKHRj1jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Fabio,

On 20/06/15 16:43, Fabio Estevam wrote:
> On Sat, Jun 20, 2015 at 11:15 AM, Philippe Reynes<tremyfr@gmail.com>  wrote:
>
>> @@ -240,6 +241,9 @@ int __init mx35_clocks_init(void)
>>          clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.1");
>>          clk_register_clkdev(clk[uart3_gate], "per", "imx21-uart.2");
>>          clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.2");
>> +       /* i.mx35 has the i.mx21 type uart */
>
> I think you meant rtc, not uart :-)

Yes, of course, sorry for this silly mistake.
I fix it in a V3.

Thanks a lot,
Philippe

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
