Date: Tue, 3 Mar 2015 21:50:32 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH v2] rtc: add Abracon ABx80x driver
Message-ID: <20150303205032.GF3892@piout.net>
References: <1425205635-3587-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150302155337.7876cfb631552427187c4c0a@linux-foundation.org>
 <20150303011116.GW4094@piout.net>
 <20150303122012.177eee47ba703bd73780b741@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150303122012.177eee47ba703bd73780b741@linux-foundation.org>
List-ID: <rtc-linux.googlegroups.com>

On 03/03/2015 at 12:20:12 -0800, Andrew Morton wrote :
> On Tue, 3 Mar 2015 02:11:16 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > On 02/03/2015 at 15:53:37 -0800, Andrew Morton wrote :
> > > On Sun,  1 Mar 2015 11:27:15 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > > 
> > > > Add support for the i2c RTC from Abracon.
> > > 
> > > What is the relationship between this patch and
> > > http://ozlabs.org/~akpm/mmots/broken-out/rtc-add-rtc-abx805-a-driver-for-the-abracon-ab-1805-i2c-rtc.patch?
> > > 
> > 
> > I'd say drop mine, I couldn't find the other one before writing it...
> > 
> > I'll try to build on Philippe's driver.
> 
> Which driver supports the most devices?  Your driver has
> 
> +static const struct i2c_device_id abx80x_id[] = {
> +	{ "abx80x", ABX80X },
> +	{ "ab0801", AB0801 },
> +	{ "ab0802", AB0802 },
> +	{ "ab0803", AB0803 },
> +	{ "ab0804", AB0804 },
> +	{ "ab0805", AB0805 },
> +	{ "ab1801", AB1801 },
> +	{ "ab1802", AB1802 },
> +	{ "ab1803", AB1803 },
> +	{ "ab1804", AB1804 },
> +	{ "ab1805", AB1805 },
> +	{ }
> +};
> 
> And Philippe's has
> 
> +static struct i2c_device_id abx805_id[] = {
> +	{ "abx805-rtc", 0 },
> +	{ }
> +};
> 
> 
> And is the naming in Philippe's driver appropriate?  If it supports the
> AB1801 (for example) then why is it described as an "abx805" driver?

The real naming is in the form ABx8yz. With:

x: 0 or 1, indicate the presence of the reset management
y: 0 or 1: 0 is i2c, 1 is spi
z: [1-5]: different amount of on chip SRAM. From what I understand, only
ABx8y5 are actually recommended for new designs.

They all share the same register set, apart from the reset management
that is only available on AB18yz.

>From my point of view, but I'm obviously biased, I'd take my patch
because it declares and supports all the available rtc and it also uses
the i2c_smbus_xxx API that is more robust than the raw i2c_transfer.

I also take care of the 12/24 mode bit and the write RTC bit which is
necessary to be able to write to the RTC.

What I like in Philippe's driver is the info printed at probe time and
the support for trickle charging. However, I wouldn't enable it
unconditionally.

To move forward, I can either send follow up patches based on what
Philippe did.

Or I can merge features from Philippe in my driver in a new patch,
keeping his authorship.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
