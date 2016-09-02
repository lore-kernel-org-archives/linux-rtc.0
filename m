Return-Path: <rtc-linux+bncBD7N3SEV2QCRBKPJUS7AKGQEHJNAR4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp2.megiteam.pl (smtp2.megiteam.pl. [213.189.52.193])
        by gmr-mx.google.com with ESMTPS id o85si195617wme.0.2016.09.02.01.13.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 01:13:29 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v4] rtc: omap: Support ext_wakeup configuration
To: Rob Herring <robh@kernel.org>
References: <20160825111912.23017-1-m.niestroj@grinn-global.com>
 <20160830195903.GA14471@rob-hp-laptop>
Cc: Tony Lindgren <tony@atomide.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, rtc-linux@googlegroups.com,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 Pawel Moll <pawel.moll@arm.com>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Keerthy <j-keerthy@ti.com>
From: Marcin Niestroj <m.niestroj@grinn-global.com>
Message-ID: <53fbdcb2-99cd-4b9d-7aea-11a2a0fb7fcb@grinn-global.com>
Date: Fri, 2 Sep 2016 10:13:12 +0200
MIME-Version: 1.0
In-Reply-To: <20160830195903.GA14471@rob-hp-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 30.08.2016 21:59, Rob Herring wrote:
> On Thu, Aug 25, 2016 at 01:19:12PM +0200, Marcin Niestroj wrote:
>> Support configuration of ext_wakeup sources. This patch makes it
>> possible to enable ext_wakeup and set it's polarity, depending on board
>> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
>> notify about power-button presses. Handling power-button presses enables
>> to recover from RTC-only power states correctly.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>> ---
>> Hi,
>>
>> This is a total reimplementation, so it is not based on any of the previos
>> patch versions. This patch adds support for ext_wakeup using generic pinconf
>> device-tree bindings, with one added "ti,input-polarity" custom property.
>> This approach has been suggested by Tony and Grygorii in [1].
>>
>> Patch was developed on 4.6, rebased on 4.8-rc3, tested using chiliBoard.
>>
>> [1] http://www.spinics.net/lists/devicetree/msg131516.html
>>
>>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  21 +++
>>  drivers/rtc/Kconfig                                |   1 +
>>  drivers/rtc/rtc-omap.c                             | 167 ++++++++++++++++++++-
>>  3 files changed, 181 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>> index bf7d11a..5d18373 100644
>> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>> @@ -18,6 +18,18 @@ Optional properties:
>>    through pmic_power_en
>>  - clocks: Any internal or external clocks feeding in to rtc
>>  - clock-names: Corresponding names of the clocks
>> +- pinctrl-0: a phandle pointing to the pin settings for the device
>> +- pinctrl-names: should be "default"
>> +
>> +Optional subnodes:
>> +- generic pinctrl node
>> +
>> +Required pinctrl subnodes properties:
>> +- pins - Names of ext_wakeup pins to configure
>> +
>> +Optional pinctrl subnodes properties:
>> +- input-enable - Enables ext_wakeup
>> +- ti,input-polarity - GPIO_ACTIVE_LOW or GPIO_ACTIVE_HIGH depending board
>
> This is not a GPIO, so don't use GPIO defines. Just make this boolean
> with not present ideally being the more common case.
>
>>  Example:
>>
>> @@ -30,4 +42,13 @@ rtc@1c23000 {
>>  	system-power-controller;
>>  	clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
>>  	clock-names = "ext-clk", "int-clk";
>> +
>> +	pinctrl-0 = <&ext_wakeup>;
>> +	pinctrl-names = "default";
>> +
>> +	ext_wakeup: ext_wakeup {
>
> Use '-', not '_' in node names.

To be sure... It should look like below?

ext_wakeup: ext-wakeup {
	pins = "ext_wakeup0";
	input-enable;
	ti,active-high;
}

>
>> +		pins = "ext_wakeup0";
>> +		input-enable;
>> +		ti,input-polarity = <GPIO_ACTIVE_LOW>;
>> +	};
>>  };

-- 
Marcin Niestroj

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
