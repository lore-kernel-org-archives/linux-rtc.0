Return-Path: <rtc-linux+bncBD2OLRXW4ABBBRWR3G2AKGQEJRQPM2I@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id jj4si178444pac.2.2016.01.13.07.09.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 07:09:58 -0800 (PST)
Message-ID: <5696665A.5030508@nvidia.com>
Date: Wed, 13 Jan 2016 20:29:38 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 5/6] rtc: max77xxx: add RTC driver for
 Maxim MAX77xxx series RTC IP
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-6-git-send-email-ldewangan@nvidia.com> <569594F0.4020007@samsung.com> <5695CD73.5010709@nvidia.com> <5695D268.3060705@samsung.com> <5695D1AF.9000806@nvidia.com>
In-Reply-To: <5695D1AF.9000806@nvidia.com>
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


On Wednesday 13 January 2016 09:55 AM, Laxman Dewangan wrote:
>
> On Wednesday 13 January 2016 09:58 AM, Krzysztof Kozlowski wrote:
>> On 13.01.2016 13:07, Laxman Dewangan wrote:
>>> On Wednesday 13 January 2016 05:36 AM, Krzysztof Kozlowski wrote:
>>
>>> That is also fine to me but still I am not comfortable with the config
>>> name and driver file name as this does not suggest the common.
>> The name does not matter. Really. We have a lot of drivers with a
>> specific device-like name and supporting different devices. To point
>> that your argument is invalid - your initial name of driver
>> "rtc-max77620.c" supported totally different "names": the max77620 and
>> max20024. It also wasn't suggesting something "common"...
> In all config string, I have mentioned the MAX20024.
>
>
>> With my approach we are not developing common think neither. We just
>> want to extend/re-use existing max77686 (or max77802) driver for new
>> devices. Just like everywhere else.
>
> OK, fine to me if this is acceptable.
> I will drop this rtc patch form this series and work in max77686 
> driver to modify first and once merged, use this config on my defconfig.
>

Here, MAX686 RTC driver needs two regmap handle, one for the rtc_regmap 
and other for STATUS2 register access.

         ret = regmap_read(info->max77686->regmap, MAX77686_REG_STATUS2, 
&val);
         if (ret < 0) {
                 dev_err(info->dev, "%s:%d fail to read status2 reg(%d)\n",
                                 __func__, __LINE__, ret);
                 goto out;
         }


We can not have two regmap handle on rtc driver as both regmap (pmic and 
rtc) registered with different i2c device.

Also this register should not be accessed by RTC driver if we want to 
decouple as this is very much MAX77686 register set.
Do we need this code?
static int max77686_rtc_read_alarm(struct device *dev, struct rtc_wkalrm 
*alrm)
{
         struct max77686_rtc_info *info = dev_get_drvdata(dev);
         u8 data[RTC_NR_TIME];
         unsigned int val;
         int i, ret;

::::::::
        alrm->pending = 0;
         ret = regmap_read(info->max77686->regmap, MAX77686_REG_STATUS2, 
&val);
         if (ret < 0) {
                 dev_err(info->dev, "%s:%d fail to read status2 reg(%d)\n",
                                 __func__, __LINE__, ret);
                 goto out;
         }

         if (val & (1 << 4)) /* RTCA1 */
                 alrm->pending = 1;

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
