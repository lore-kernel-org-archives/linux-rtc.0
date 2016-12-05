Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCW5S7BAKGQEGYCKY6Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id o77si100042wme.0.2016.12.05.14.47.37
        for <rtc-linux@googlegroups.com>;
        Mon, 05 Dec 2016 14:47:37 -0800 (PST)
Date: Mon, 5 Dec 2016 23:47:33 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: mcp795: fix month write resetting
 date to 1.
Message-ID: <20161205224733.rioq3c4icjjkrg4c@piout.net>
References: <cover.1480939487.git.emilbart@gmail.com>
 <6a1e8548654fd8a5b65ba98f59b2b5ccb1544f7f.1480939487.git.emilbart@gmail.com>
 <20161205152410.qj64rw67jdccyrab@piout.net>
 <20161205221655.GA15764@emba-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161205221655.GA15764@emba-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/12/2016 at 23:16:55 +0100, Emil Bartczak wrote :
> > > +static int mcp795_start_oscillator(struct device *dev)
> > > +{
> > > +	return mcp795_rtcc_set_bits(dev, MCP795_REG_SECONDS,
> > > +					MCP795_ST_BIT, MCP795_ST_BIT);
> > 
> > You probably want to restore EXTOSC to its previous value here.
> I came to the conclusion that it is better to remove clearing of bit EXTOSC in function mcp795_stop_oscillator.
> Because regarding datasheet, after power up the RTC chip (or reset) that bit has value 0.
> What do you think?
>  

That is one way but maybe some people are setting that bit in the
bootloader. It doesn't matter much. If you are not using the feature,
let it that way. If anybody needs it at some point they can still send a
patch :)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
