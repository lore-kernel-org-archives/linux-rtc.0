Return-Path: <rtc-linux+bncBDEKVJM7XAHRB4UJ4TBQKGQEP3YT26A@googlegroups.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com. [2607:f8b0:4003:c06::241])
        by gmr-mx.google.com with ESMTPS id 13si186519itg.2.2017.01.13.08.48.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 08:48:50 -0800 (PST)
Received: by mail-oi0-x241.google.com with SMTP id u143so7412860oif.3
        for <rtc-linux@googlegroups.com>; Fri, 13 Jan 2017 08:48:50 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
References: <20170113153311.2611510-1-arnd@arndb.de> <20170113153311.2611510-3-arnd@arndb.de>
 <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 13 Jan 2017 17:48:49 +0100
Message-ID: <CAK8P3a3vzwB5MDiVse+meK17KKHtaZWzmOkfzJ2d=n=sgjzkRw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Jan 13, 2017 at 4:56 PM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> On 01/13/2017 04:32 PM, Arnd Bergmann wrote:
>>
>> Using the ~ operator on a BIT() constant results in a large 'unsigned
>> long'
>> constant that won't fit into an 'unsigned int' function argument on 64-bit
>> architectures, resulting in a harmless build warning in x86 allmodconfig:
>>
>> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
>> drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated
>> to unsigned type [-Werror=overflow]
>>   regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
>
> I thought I would fix this warning by replacing all ~PWR_CR_DBP by 0,
> because the mask PWR_CR_DBP prevents other bits to be cleared.
> In this way, I avoid the ugly cast...

Good idea, much nicer than mine! Can you send that patch?

    Arnd

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
