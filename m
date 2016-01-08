Return-Path: <rtc-linux+bncBD2OLRXW4ABBBPHMX22AKGQEBQUHKVA@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id a76si308348pfj.2.2016.01.08.05.14.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 05:14:36 -0800 (PST)
Message-ID: <568FB3DD.4090503@nvidia.com>
Date: Fri, 8 Jan 2016 18:34:29 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<rtc-linux@googlegroups.com>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <linus.walleij@linaro.org>, <gnurou@gmail.com>,
	<lee.jones@linaro.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com> <1452177524-23192-6-git-send-email-ldewangan@nvidia.com> <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com> <568F8D7E.10500@nvidia.com> <20160108125117.GM6588@sirena.org.uk>
In-Reply-To: <20160108125117.GM6588@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On Friday 08 January 2016 06:21 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Fri, Jan 08, 2016 at 03:50:46PM +0530, Laxman Dewangan wrote:
>
>> Yaah, that is the issue on IP based PMIC system and it happen with the Maxim
>> and TI.
>> The MFD and its sub module drivers are too much couped  and hence dificult
>> to use the IP driver across PMIC. For almost all Maxim PMIC, we end up of
>> same type of RTC driver.
>> Probably, we need to enhance the mfd sub system to allow sub module driver
>> to decoupe from its APIs.
> Could you be more specific about the issues here please?  I can't think
> of any barriers and you've not mentioned any barriers...
>

I took MAX77686 and MAX77620. They are almost same IP on both PMIC and I 
think it can be used if we decouple it. Typical codes are same as 
follows: (I posted here for quick reference, excuse me if it is long).


If we get the parent device, regmap handle and interrupt number from mfd 
core independent of the PMIC (MAX77620 or MAX77686), then same driver 
can be used here.
Two way which I can think of here:

1: We need to make independent maxim RTC IP driver which may be platform 
driver and get above information from the platform data.

This way both mfd driver can pass the platform data with required 
information and decoupled.

2. Other way is that rtc driver will register as independent platform 
driver and pass the mfd dt handle to this driver. Later maxim rtc driver 
can query for getting the regmap, interrupt number etc.

Any other approach are welcome.


sample code:
************************8
Typical function from max77686:

static int max77686_rtc_set_time(struct device *dev, struct rtc_time *tm)
{
         struct max77686_rtc_info *info = dev_get_drvdata(dev);
         u8 data[RTC_NR_TIME];
         int ret;

         ret = max77686_rtc_tm_to_data(tm, data);
         if (ret < 0)
                 return ret;

         mutex_lock(&info->lock);

         ret = regmap_bulk_write(info->max77686->rtc_regmap,
                                  MAX77686_RTC_SEC, data, RTC_NR_TIME);
         if (ret < 0) {
                 dev_err(info->dev, "%s: fail to write time reg(%d)\n", 
__func__,
                                 ret);
                 goto out;
         }

         ret = max77686_rtc_update(info, MAX77686_RTC_WRITE);

out:
         mutex_unlock(&info->lock);
         return ret;
}


static int max77620_rtc_set_time(struct device *dev, struct rtc_time *tm)
{
         struct max77620_rtc *rtc = dev_get_drvdata(dev);
         struct device *parent = max77620_to_parent(rtc);
         u8 buf[RTC_NR];
         int ret;

         ret = max77620_rtc_tm_to_reg(rtc, buf, tm, 0);
         if (ret < 0)
                 return ret;

         mutex_lock(&rtc->io_lock);

         ret = max77620_reg_writes(parent, MAX77620_RTC_SLAVE, addr, 
len, vals);
         if (ret < 0) {
                 dev_err(rtc->dev, "Reg 0x%02x write failed: %d\n", 
addr, ret);
                 goto out;
         }

         ret = max77620_rtc_update_buffer(rtc, 1);

out:
         mutex_unlock(&rtc->io_lock);

         return ret;
}




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
