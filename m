Return-Path: <rtc-linux+bncBCEPJZEDQIBBB5GQSS6AKGQEEEQFHNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk. [185.25.241.215])
        by gmr-mx.google.com with ESMTPS id d196si108392wmd.1.2016.07.12.10.27.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 10:27:16 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 1/4] rtc: support for amlogic meson rtc
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1467748122-14833-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467748122-14833-3-git-send-email-ben.dooks@codethink.co.uk>
 <20160712172235.GU22202@piout.net>
Cc: linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org,
 rtc-linux@googlegroups.com, a.zummo@towertech.it,
 devicetree@vger.kernel.org, narmstrong@baylibre.com, frowand.list@gmail.com,
 khilman@baylibre.com
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-ID: <4d98df06-cf00-b4fd-dfb5-1ac5d9c548fc@codethink.co.uk>
Date: Tue, 12 Jul 2016 18:27:12 +0100
MIME-Version: 1.0
In-Reply-To: <20160712172235.GU22202@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/07/16 18:22, Alexandre Belloni wrote:
> Hi,
> 
> Very few comments below
> 
> On 05/07/2016 at 20:48:41 +0100, Ben Dooks wrote :
>> +/* registers accessed from cpu bus */
>> +#define RTC_REG(x)		((x) * 4)	/* rtc registers 0-4 */
>> +
>> +#define LINE_SDI		(1 << 2)
>> +#define LINE_SEN		(1 << 1)
>> +#define LINE_SCLK		(1 << 0)
> 
> Maybe use BIT() here.

I'll sort that out later.

>> +/* RTC interface layer functions */
>> +
>> +static int meson_rtc_gettime(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct meson_rtc *rtc = dev_get_drvdata(dev);
>> +	int ret;
>> +	u32 time;
>> +
>> +	mutex_lock(&rtc->lock);
>> +
>> +	ret = meson_rtc_read(rtc, RTC_COUNTER, &time);
>> +	if (!ret) {
>> +		rtc_time_to_tm(time, tm);
> 
> Can you use the 64bit version?

What would the 64bit version gain? The hardware register is 32bit.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
