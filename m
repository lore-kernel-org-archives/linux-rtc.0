Return-Path: <rtc-linux+bncBCXY5EGBQUIBBMOAQOYQKGQEONO76OY@googlegroups.com>
Received: from mail-out.m-online.net (mail-out.m-online.net. [2001:a60:0:28:0:1:25:1])
        by gmr-mx.google.com with ESMTPS id w4si231384wiz.0.2015.10.16.04.32.01
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 04:32:01 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2] rtc: pcf8563: add CLKOUT to common clock framework
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1444982369-26046-1-git-send-email-hs@denx.de>
 <20151016105446.GK3421@piout.net> <20151016110051.GM3421@piout.net>
Cc: linux-kernel@vger.kernel.org, Georg.Soffel@bosch-si.com,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 devicetree@vger.kernel.org
From: Heiko Schocher <hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
Message-ID: <5620E02D.2000605@denx.de>
Date: Fri, 16 Oct 2015 13:31:57 +0200
MIME-Version: 1.0
In-Reply-To: <20151016110051.GM3421@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello Alexandre,

Am 16.10.2015 um 13:00 schrieb Alexandre Belloni:
> On 16/10/2015 at 12:54:46 +0200, Alexandre Belloni wrote :
>>> +static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
>>> +{
>>> +	struct i2c_client *client = pcf8563->client;
>>> +	struct device_node *node = client->dev.of_node;
>>> +	struct clk *clk;
>>> +	struct clk_init_data init;
>>> +	int ret;
>>> +	unsigned char buf;
>>> +
>>> +	/* disable the clkout output */
>>> +	buf = 0;
>>> +	ret = pcf8563_write_block_data(client, PCF8563_REG_CLKO, 1, &buf);
>>> +	if (ret < 0)
>>> +		return ERR_PTR(ret);
>>> +
>>
>> Isn't that done automatically for an unused clock? However, I would do
>> that in the probe as you will have to sprinkle some #ifdef
>> CONFIG_COMMON_CLK after seeing the kbuild report.
>
> I'm rethinking about your comment about breaking existing boards. I'd
> say that probably nobody is using the output from the rtc but maybe
> (highly unlikely) some are configuring it from the bootloader and in
> that case it is not nice to undo that configuration. Let's keep that
> block here as long as it works fine for you.

Ok, so I have also a better feeling with it ... removing it back ;-)

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

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
