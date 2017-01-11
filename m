Return-Path: <rtc-linux+bncBC2IT2GSZUDRBCXL3DBQKGQEVQ74XLI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id l66si404050wml.0.2017.01.11.05.39.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 05:39:22 -0800 (PST)
Subject: [rtc-linux] Re: [PATCHv4 3/8] rtc: add STM32 RTC driver
To: Corentin Labbe <clabbe.montjoie@gmail.com>
References: <1484138905-5903-1-git-send-email-amelie.delaunay@st.com>
 <20170111130438.GA9327@Red>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
From: Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <b9ed4f2f-5d41-6041-0215-c3ff11843198@st.com>
Date: Wed, 11 Jan 2017 14:39:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170111130438.GA9327@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Corentin,

Thanks for reviewing,

On 01/11/2017 02:04 PM, Corentin Labbe wrote:
> On Wed, Jan 11, 2017 at 01:48:25PM +0100, Amelie Delaunay wrote:
>> This patch adds support for the STM32 RTC.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>  drivers/rtc/Kconfig     |  11 +
>>  drivers/rtc/Makefile    |   1 +
>>  drivers/rtc/rtc-stm32.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 739 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-stm32.c
>
> [...]
>> +/* STM32_PWR_CR */
>> +#define PWR_CR				0x00
>> +/* STM32_PWR_CR bit field */
>> +#define PWR_CR_DBP			BIT(8)
>> +
>> +static struct regmap *dbp;
>
> Hello
>
> Why using a global static struct ?
> You could alloc a private structure in probe for storing it and use platform_set_drvdata()
>
This is to stay closer to how this backup domain protection is managed 
in clk-stm32f4 driver, but I realize that I haven't the same 
constraints. I'll move this struct in my stm32_rtc private structure.

> Regards
>

Regards

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
