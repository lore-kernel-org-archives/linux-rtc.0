Return-Path: <rtc-linux+bncBDKZNNNLXAHBBY7Q2G2AKGQEGXZKYQA@googlegroups.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com. [210.118.77.11])
        by gmr-mx.google.com with ESMTPS id jj4si12221602pac.2.2016.01.11.19.52.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 19:52:02 -0800 (PST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O0T00274MQLSN10@mailout1.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 12 Jan 2016 03:51:57 +0000 (GMT)
Subject: Re: [rtc-linux] [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-6-git-send-email-ldewangan@nvidia.com>
 <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com>
 <568F8D7E.10500@nvidia.com> <20160108125117.GM6588@sirena.org.uk>
 <568FB3DD.4090503@nvidia.com> <20160108133648.GQ6588@sirena.org.uk>
 <568FBB6D.2020904@nvidia.com> <5693AB6E.4090700@nvidia.com>
 <20160111160419.GA3367@piout.net> <5693E14B.4050306@nvidia.com>
 <56944520.6090301@samsung.com> <569465DA.10609@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, rtc-linux@googlegroups.com,
 robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linus.walleij@linaro.org,
 gnurou@gmail.com, lee.jones@linaro.org, a.zummo@towertech.it,
 lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, swarren@nvidia.com, treding@nvidia.com,
 Chaitanya Bandi <bandik@nvidia.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56947857.30709@samsung.com>
Date: Tue, 12 Jan 2016 12:51:51 +0900
MIME-version: 1.0
In-reply-to: <569465DA.10609@nvidia.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12.01.2016 11:32, Laxman Dewangan wrote:
> 
> On Tuesday 12 January 2016 05:43 AM, Krzysztof Kozlowski wrote:
>> On 12.01.2016 02:07, Laxman Dewangan wrote:
>>>>> The RTC driver parent is not the same parent for which i2c slave
>>>>> address get
>>>>> registered.
>>>>> There is two slave address from max77620, 0x3C (for general) and 0x68
>>>>> for
>>>>> RTC.
>>>>>
>>>>> In max77620 mfd driver, we make dummy i2c client for 0x68 and
>>>>> initialize
>>>>> regmap with this address.
>>>>>
>>>>> Now on mfd_add_devices, we pass the device for 0x3c and hence the RTC
>>>>> driver
>>>>> treat the parent as the 0x3c device but actually it should be 0x68 to
>>>>> get
>>>>> the proper regmap.
>>>>>
>>>>>
>>>>> Two approach:
>>>>> 1. If we add the option to pass parent_dev when adding cells form
>>>>> mfd_add_devices and select the parent device based on this option
>>>>> then it
>>>>> can be easily handle.
>>>>>       Add parent_dev structure in struct mfd_cell and then change the
>>>>> parent
>>>>> in mfd_add_device() if cells has parent device.
>>>>>
>>>>> 2. Register the RTC driver with different mfd_add_devices with
>>>>> dummy i2c
>>>>> client device.
>>>>> So two times mfd_add_devices.
>> Lexman,
>>
>> I don't quite get the problem. This looks exactly the same as for
>> max77686. What is the difference? I don't see any need to change the
>> mfd_cell for current drivers...
>>
>>
> 
> Here the change is only required to pass the regmap handle from mfd to
> the rtc driver. There is no change for rest of rtc driver.
> 
> RTC i2c regmap registered with i2c dummy client device, not with actual
> parent device and hence we need to register RTC with this dummy i2c
> client device. This way we can get regmap handle by using the
> dev_get_regmap(pdev->dev.parent).

It seems that both max77620 and max77686 use separate I2C addresses for
RTC block. The max77802 does not. This means that probably each child
driver should be responsible for its own regmap. The max77620 and
max77686 will create new I2C dummy devices and new regmaps. The max77802
will re-use references passed by parent (MFD).

Best regards,
Krzysztof

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
