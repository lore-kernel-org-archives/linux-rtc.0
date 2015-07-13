Return-Path: <rtc-linux+bncBCF2PQPV4MDRBAF2SCWQKGQEXY77A4A@googlegroups.com>
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com. [2a00:1450:4010:c04::22e])
        by gmr-mx.google.com with ESMTPS id h8si566851lbd.3.2015.07.13.13.18.08
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 13:18:08 -0700 (PDT)
Received: by mail-lb0-x22e.google.com with SMTP id f12so61974604lbl.2
        for <rtc-linux@googlegroups.com>; Mon, 13 Jul 2015 13:18:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150713173739.GF25028@jcartwri.amer.corp.natinst.com>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
	<1436635730-15617-2-git-send-email-manabian@gmail.com>
	<20150713173739.GF25028@jcartwri.amer.corp.natinst.com>
Date: Mon, 13 Jul 2015 22:18:08 +0200
Message-ID: <CAGhQ9VyJw6+6ALYtw_Lu3OO4SMdT1hJxB1+aZHtOfC-0OU4Bnw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 1/2] rtc: add rtc-lpc24xx driver
From: Joachim  Eastwood <manabian@gmail.com>
To: Josh Cartwright <joshc@ni.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13 July 2015 at 19:37, Josh Cartwright <joshc@ni.com> wrote:
> On Sat, Jul 11, 2015 at 07:28:49PM +0200, Joachim Eastwood wrote:
>> Add driver for the RTC found on NXP LPC178x/18xx/408x/43xx devices.
>> The RTC provides calendar and clock functionality together with
>> alarm interrupt support.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
> [..]
>> +static int lpc24xx_rtc_remove(struct platform_device *pdev)
>> +{
>> +     struct lpc24xx_rtc *rtc = platform_get_drvdata(pdev);
>> +
>> +     /* Ensure all interrupt sources are masked */
>> +     rtc_writel(rtc, LPC24XX_AMR, LPC24XX_ALARM_DISABLE);
>> +     rtc_writel(rtc, LPC24XX_CIIR, 0);
>> +
>> +     rtc_writel(rtc, LPC24XX_CCR, LPC178X_CCALEN);
>> +
>> +     clk_disable_unprepare(rtc->clk_rtc);
>> +     clk_disable_unprepare(rtc->clk_reg);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id lpc24xx_rtc_match[] = {
>> +     { .compatible = "nxp,lpc1788-rtc" },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpc24xx_rtc_match);
>> +
>> +static struct platform_driver lpc24xx_rtc_driver = {
>> +     .probe  = lpc24xx_rtc_probe,
>> +     .remove = lpc24xx_rtc_remove,
>> +     .driver = {
>> +             .name = "lpc24xx-rtc",
>> +             .of_match_table = lpc24xx_rtc_match,
>> +     },
>> +};
>> +module_platform_driver(lpc24xx_rtc_driver);
>> +
>> +MODULE_AUTHOR("Kevin Wells <wellsk40@gmail.com");
>
> Missing closing '>'.

Ops. Well spotted.

> Otherwise,
>
> Reviewed-by: Josh Cartwright <joshc@ni.com>

Thanks, Josh.

I'll wait and see if Alexandre has any other comments before sending a
new version.


regards,
Joachim Eastwood

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
