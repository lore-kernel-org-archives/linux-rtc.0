Return-Path: <rtc-linux+bncBAABBIM7TSVQKGQED73P2SI@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com. [195.245.230.169])
        by gmr-mx.google.com with ESMTPS id p12si128043wiv.1.2015.05.28.05.52.48
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 05:52:49 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Lee Jones <lee.jones@linaro.org>
CC: LINUXKERNEL <linux-kernel@vger.kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll
	<pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring
	<robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [rtc-linux] RE: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
Date: Thu, 28 May 2015 12:52:45 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22DEC7@SW-EX-MBX02.diasemi.com>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
 <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
 <20150526161024.GQ11677@x1>
In-Reply-To: <20150526161024.GQ11677@x1>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Lee, 

I will refactor a lot of the driver and implement your changes as requested.
I think the only major differences with your comments will be as follows:

- the interrupt handler da9062_vdd_warn_event() will be erased
- I would prefer the register header file to remain  [mostly] untouched 

Please find more detailed comments below.

thanks,
Steve

On 26 May 2015 17:10 Lee Jones wrote

> To: Opensource [Steve Twiss]
> Cc: LINUXKERNEL; Samuel Ortiz; Alessandro Zummo; DEVICETREE; David
> Dajun Chen; Dmitry Torokhov; Ian Campbell; Kumar Gala; LINUXINPUT;
> LINUXWATCHDOG; Liam Girdwood; Mark Brown; Mark Rutland; Pawel Moll;
> RTCLINUX; Rob Herring; Support Opensource; Wim Van Sebroeck
> Subject: Re: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
> 
> On Tue, 19 May 2015, S Twiss wrote:
> 
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add MFD core driver support for DA9062
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >

[...]

> > diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> > new file mode 100644
> > index 0000000..5aea082
> > --- /dev/null
> > +++ b/drivers/mfd/da9062-core.c
> > @@ -0,0 +1,611 @@
> > +/*
> > + * da9062-core.c - CORE device driver for DA9062
> 
> Remove the filename.  They have a habit of becoming incorrect.
> 
> s/CORE/Core/
> 
> Can you also mention what the DA9062 actually is?
> 

Will remove filename, and add a description
"Core, IRQ and I2C driver for DA9062 PMIC" 

[...]

> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +
> 
> Why the '\n'?
> 
> > +#include <linux/irq.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/i2c.h>
> > +#include <linux/err.h>
> > +
> 
> Same here?
> 
> > +#include <linux/mfd/da9062/core.h>
> > +#include <linux/mfd/da9062/registers.h>
> > +#include <linux/of.h>
> > +#include <linux/regulator/of_regulator.h>
> > +
> > +#include <linux/proc_fs.h>
> > +#include <linux/kthread.h>
> > +#include <linux/uaccess.h>
> 
> I'm a bit concerned by the number of includes here, are you sure
> they're all required?
> 
> > +/* IRQ device driver for DA9062 */
> 
> Not sure what this means?

Removed unnecessary whitespace throughout the patches.
And erased comments throughout  that are not required

[...]

> > +int da9062_irq_init(struct da9062 *chip)
> > +{
> > +	int ret;
> > +
> > +	if (!chip->chip_irq) {
> 
> Check this once, in probe(), then rid this check.
> 
> > +		dev_err(chip->dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_add_irq_chip(chip->regmap, chip->chip_irq,
> > +			IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> IRQF_SHARED,
> > +			chip->irq_base, &da9062_irq_chip,
> > +			&chip->regmap_irq);
> 
> This is just one call.  Just place that call into
> da9062_device_init() and rid this function.
> 

Will refactor this part.

> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
> > +			chip->chip_irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void da9062_irq_exit(struct da9062 *chip)
> > +{
> > +	regmap_del_irq_chip(chip->chip_irq, chip->regmap_irq);
> 
> Again, this is abstraction for the sake of abstraction.
> 

I will erase all abstractions and ...
  - Refactor da9062_device_init() and da9062_irq_init() into probe
  - Add new function get_device_type() for variant and device_id information

[...]

> > +static struct resource da9062_wdt_resources[] = {
> > +	{
> > +		.name	= "WDG_WARN",
> > +		.start	= DA9062_IRQ_WDG_WARN,
> > +		.end	= DA9062_IRQ_WDG_WARN,
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> 
> Convert all of these to oneliners using DEFINE_RES_* macros.

Done.

> > +
> > +static irqreturn_t da9062_vdd_warn_event(int irq, void *data)
> > +{
> > +	struct da9062 *hw = data;
> > +
> > +	dev_err(hw->dev, "VDD warning indicator\n");
> 
> Is it an error?  Doesn't look like it.
> 
> > +	return IRQ_HANDLED;
> > +}

See later on (this is to be erased)

[...]

> > +static int da9062_clear_fault_log(struct da9062 *chip)
> > +{
> > +	int ret = 0;
> 
> No need to pre-initialise.
> 
> > +	int fault_log = 0;
> 
> As above.
> 
> > +	ret = regmap_read(chip->regmap, DA9062AA_FAULT_LOG,
> &fault_log);
> > +	if (ret < 0) {
> > +		dev_err(chip->dev, "Cannot read FAULT_LOG.\n");
> > +		ret = -EIO;
> 
> Just return and rid the else.
> 
> > +	} else {
> > +		if (fault_log) {
> > +			if (fault_log & DA9062AA_TWD_ERROR_MASK)

I will refactor da9062_clear_fault_log() to remove inconsistencies

> > +int da9062_device_init(struct da9062 *chip, unsigned int irq)
> 
> No need to pass irq, as it's part of chip.
> 

This is going to be erased as part of a later comment (see below)

[...]

> > +	ret = da9062_clear_fault_log(chip);
> > +	if (ret < 0)
> > +		dev_err(chip->dev, "Cannot clear fault log\n");
> 
> If this is an error, you must return.  If it's just a warning then use
> dev_warn().

Will use dev_warn instead

> 
> > +	chip->irq_base = -1;
> 
> Why are you pre-initialising?
> 
> > +	chip->chip_irq = irq;
> 
> You already assigned irq to chip_irq.
> 
> > +	ret = regmap_read(chip->regmap, DA9062AA_DEVICE_ID,
> &device_id);
> > +	if (ret < 0) {
> > +		dev_err(chip->dev, "Cannot read chip ID.\n");
> > +		return -EIO;
> > +	}
> > +	if (device_id != DA9062_PMIC_DEVICE_ID) {
> > +		dev_err(chip->dev, "Invalid device ID: 0x%02x\n",
> device_id);
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = regmap_read(chip->regmap, DA9062AA_VARIANT_ID,
> &variant_id);
> > +	if (ret < 0) {
> > +		dev_err(chip->dev, "Cannot read chip variant id.\n");
> > +		return -EIO;
> > +	}
> > +
> > +	dev_info(chip->dev,
> > +		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X)\n",
> > +		 device_id, variant_id);
> 
> Probably best to put this at the end.

I have left this part in at this point. The device_id and variant_id are not
passed any further than this function for the moment.

> 
> > +	variant_mrc = (variant_id & DA9062AA_MRC_MASK) >>
> DA9062AA_MRC_SHIFT;
> > +
> > +	if (variant_mrc < DA9062_PMIC_VARIANT_MRC_AA) {
> > +		dev_err(chip->dev,
> > +			"Cannot support variant MRC: 0x%02X\n",
> variant_mrc);
> > +		return -ENODEV;
> > +	}
> 
> I'd put all of the device/variant stuff it its own function, then move
> everything else into probe() and remove da9062_device_init().
> 

I will make a new function get_device_type() for variant and device_id information

> > +	ret = da9062_irq_init(chip);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Cannot initialize interrupts.\n");
> > +		return ret;
> > +	}
> 
> Remove this function and call regmap_add_irq_chip() from here.
> 

Yes. I will do that.

> > +	chip->irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
> > +
> > +	ret = mfd_add_devices(chip->dev, -1, da9062_devs,
> 
> Use PLATFORM_DEVID_NONE instead.
> 
> > +			      ARRAY_SIZE(da9062_devs), NULL, chip->irq_base,
> > +			      NULL);
> 
> Usually child devices are probed at the end i.e. the last thing in
> probe().
> 

Ok. I will move that to the end and use the PLATFORM_DEVID_NONE instead
of the explicit -1 value.

> > +	if (ret) {
> > +		dev_err(chip->dev, "Cannot add MFD cells\n");
> 
> "Cannot register child devices".
> 

Will replace that.

[...]

> > +	/* VDD WARN event support */
> > +	irq_vdd_warn = regmap_irq_get_virq(chip->regmap_irq,
> > +					   DA9062_IRQ_VDD_WARN);
> > +	if (irq_vdd_warn < 0) {
> > +		dev_err(chip->dev, "Failed to get IRQ.\n");
> > +		return irq_vdd_warn;
> > +	}
> > +	chip->irq_vdd_warn = irq_vdd_warn;
> > +
> > +	ret = devm_request_threaded_irq(chip->dev, irq_vdd_warn,
> > +					NULL, da9062_vdd_warn_event,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +					"VDD_WARN", chip);
> > +	if (ret) {
> > +		dev_warn(chip->dev,
> > +			 "Failed to request VDD_WARN IRQ.\n");
> > +		chip->irq_vdd_warn = -ENXIO;
> > +	}
> 
> This looks like a lot of code, which doesn't really do anything.  What
> is a VDD warning indicator anyway?
> 

I will remove this.

The IRQ handler da9062_vdd_warn_event() -- see earlier above -- does
not currently do anything apart from handle the IRQ that was requested
here. It prints a statement to say the main PMIC voltage supply dropped
below a defined trigger point, but doesn't actually do anything to mitigate
this problem.

Previously this VDD_WARN was in the regulator driver, however it should
be made available even if the regulator driver is not installed -- so I added it
to the core instead.

In a previous driver submission I had a similar problem, a warning IRQ was
just printing to the console to say there was an error -- the handler and
IRQ code was put in by me so it could be used if the driver was taken and
integrated into a fully working system.

I was asked to remove it in the other driver -- and I have done the same
here for now. I can always add it back later.

> > +	return ret;
> > +}
> > +
> > +void da9062_device_exit(struct da9062 *chip)
> > +{
> > +	mfd_remove_devices(chip->dev);
> > +	da9062_irq_exit(chip);
> > +}
> 
> Another seemingly pointless abstraction.  Why don't you do this in
> remove()?
> 

Will do that as part of the abstraction clean up

[...]

> > +
> > +static struct regmap_config da9062_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.ranges = da9062_range_cfg,
> > +	.num_ranges = ARRAY_SIZE(da9062_range_cfg),
> > +	.max_register = DA9062AA_CONFIG_ID,
> > +	.cache_type = REGCACHE_RBTREE,
> > +};
> > +
> > +static const struct of_device_id da9062_dt_ids[] = {
> > +	{ .compatible = "dlg,da9062", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, da9062_dt_ids);
> 
> Move this just above where it's to be used i.e. down to the bottom.
> 

Will move that to the end of the file.

> > +static int da9062_i2c_probe(struct i2c_client *i2c,
> > +	const struct i2c_device_id *id)
> > +{
> > +	struct da9062 *chip;
> > +	int ret;
> > +
> > +	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9062), GFP_KERNEL);
> 
> sizeof(*chip)
> 
> > +	if (chip == NULL)
> 
> if (!chip)

Will do that.

> > +	da9062_regmap_config.rd_table = &da9062_aa_readable_table;
> > +	da9062_regmap_config.wr_table = &da9062_aa_writeable_table;
> > +	da9062_regmap_config.volatile_table = &da9062_aa_volatile_table;
> 
> Why are you doing this here instead of inside
> 'struct regmap_config da9062_regmap_config' above?
> 

Ok.. I will fix that part into the main structure.


> > +static const struct i2c_device_id da9062_i2c_id[] = {
> > +	{"da9062", 0},
> 
> White space discipline.
> 

I have put some white-spaces in the code.
I think this:

{ "da9062", 0 },
{ },

[...]

> 
> > +MODULE_DESCRIPTION("CORE device driver for Dialog DA9062");
> 
> s/CORE/Core/
> 

Yes.

> > +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> 
> Full names please.
> 

Ok. 

[...]

> > diff --git a/include/linux/mfd/da9062/core.h
> b/include/linux/mfd/da9062/core.h
> > new file mode 100644
> > index 0000000..0b17891
> > --- /dev/null
> > +++ b/include/linux/mfd/da9062/core.h
> > @@ -0,0 +1,62 @@
> > +/*
> > + * core.h - CORE H for DA9062
> 
> What does this add?
> 

Removed the top line completely

[...]

> > +
> > +struct da9062 {
> > +	struct device *dev;
> > +	unsigned char device_id;
> > +	unsigned char variant_mrc;
> > +	struct regmap *regmap;
> > +	int chip_irq;
> > +	unsigned int irq_base;
> > +	struct regmap_irq_chip_data *regmap_irq;
> > +	int irq_vdd_warn;
> > +};
> 
> Are all of these used by child devices?
> 

After I did the refactoring work described above, I can remove quite a few of them.

unsigned char device_id;
unsigned char variant_mrc;

These are not currently used in any child device drivers -- because there is only
one device of this type.

int chip_irq;
unsigned int irq_base;

The chip_id is now local to the probe and can replaced with i2c->irq in that function
It's only use is during clean-up and i2c->irq can be used there also.
irq_base is local to probe() also, so I have made it automatic.

> > +	int irq_vdd_warn;

I have removed the vdd_warn capability in this patch.

> > +int da9062_device_init(struct da9062 *, unsigned int);
> > +int da9062_irq_init(struct da9062 *);
> > +
> > +void da9062_device_exit(struct da9062 *);
> > +void da9062_irq_exit(struct da9062 *);
> 
> Why are these required?
> 

Gone.

[...]

> > diff --git a/include/linux/mfd/da9062/registers.h
> b/include/linux/mfd/da9062/registers.h
> > new file mode 100644
> > index 0000000..d07c2bc
> > --- /dev/null
> > +++ b/include/linux/mfd/da9062/registers.h

[...]

> > +/*
> > + * Registers
> > + */
> 
> Really? ;)
> 
> > +#define DA9062AA_PAGE_CON		0x000
> > +#define DA9062AA_STATUS_A		0x001
> > +#define DA9062AA_STATUS_B		0x002

[...]

> > +
> > +/*
> > + * Bit fields
> > + */
> > +
> > +/* DA9062AA_PAGE_CON = 0x000 */
> > +#define DA9062AA_PAGE_SHIFT		0
> > +#define DA9062AA_PAGE_MASK		(0x3f << 0)
> > +#define DA9062AA_WRITE_MODE_SHIFT	6
> > +#define DA9062AA_WRITE_MODE_MASK	(0x01 << 6)
> 
> For 1 << X, you should use BIT(X).
> 

For the two comments above "Registers" and "Bit fields" and the (1<<x)
definitions ...

The whole of this file is automatically generated by our hardware designers
I would prefer it if the register definitions and bit fields are not altered using
the #define BIT(nr) (1UL<<(nr)) macro and the comments removed because
we have scripts that can be used to check this file automatically.

Also if the register map is ever updated, then it will be easier for me to diff
the new delivered register and bit field definitions with the old one.

My preference would be not to change this header file.

[...]

If I have left anything out please let me know.

regards,
Steve

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
