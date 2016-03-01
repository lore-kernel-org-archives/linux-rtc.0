Return-Path: <rtc-linux+bncBDU7VC56WAFBBG473C3AKGQEGW5JUGI@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id s141si91303wmd.1.2016.03.01.13.54.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 13:54:34 -0800 (PST)
Date: Tue, 1 Mar 2016 22:54:01 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc-rv3029c2: Add trickle charger
Message-ID: <20160301225401.3f0aeabb@wiggum>
In-Reply-To: <20160301213655.GG23985@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2l/I0deTJQiM5JKvEfYjP9D"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/2l/I0deTJQiM5JKvEfYjP9D
Content-Type: text/plain; charset=UTF-8

On Tue, 1 Mar 2016 22:36:55 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> > The kconfig name is also changed to include the chip number as
> > there are other MicroCrystal RTCs.
> >   
> 
> This should have been another patch and will conflict with my patch
> doing exactly that, see rtc-next.

Ok, will remove that.

> > Also a "rv3029" device ID was added, because the C2 suffix does
> > not appear in latest chip versions and datasheet versions.
> >   
> 
> This change should also be part of another patch.

Well, ok.

> You may as well stop adding that suffix to newly added functions and
> macros.
> I'd also take a preliminary patch removing the c2 prefix from current
> functions and macros.
> 
> Unfortunately, we can't rename the file because this will break scripts
> loading modules.
> 
> >  /* Register map */
> >  /* control section */
> >  #define RV3029C2_ONOFF_CTRL		0x00
> > +#define RV3029C2_ONOFF_CTRL_WE		(1 << 0)
> > +#define RV3029C2_ONOFF_CTRL_TE		(1 << 1)
> > +#define RV3029C2_ONOFF_CTRL_TAR		(1 << 2)
> > +#define RV3029C2_ONOFF_CTRL_EERE	(1 << 3)
> > +#define RV3029C2_ONOFF_CTRL_SRON	(1 << 4)
> > +#define RV3029C2_ONOFF_CTRL_TD0		(1 << 5)
> > +#define RV3029C2_ONOFF_CTRL_TD1		(1 << 6)
> > +#define RV3029C2_ONOFF_CTRL_CLKINT	(1 << 7)  
> 
> You didn't use --strict for checkpatch, please use BIT() and also
> correct the alignments issues.

It's what the current code already does. But I can change it all to BIT.

> >  #define RV3029C2_IRQ_CTRL		0x01
> >  #define RV3029C2_IRQ_CTRL_AIE		(1 << 0)
> > +#define RV3029C2_IRQ_CTRL_TIE		(1 << 1)
> > +#define RV3029C2_IRQ_CTRL_V1IE		(1 << 2)
> > +#define RV3029C2_IRQ_CTRL_V2IE		(1 << 3)
> > +#define RV3029C2_IRQ_CTRL_SRIE		(1 << 4)  
> 
> I'm pretty sure many you are adding many of those but not using them
> yet.

Yes. I'm adding all missing register definitions. I didn't really see
the need for splitting this further.

> >  /* user ram section */
> >  #define RV3029C2_USR1_RAM_PAGE		0x38
> > @@ -84,6 +111,7 @@
> >  #define RV3029C2_USR2_RAM_PAGE		0x3C
> >  #define RV3029C2_USR2_SECTION_LEN	0x04
> >  
> > +  
> 
> spurious blank line

Hm yes. Just adds some space to separate the reg definitions.

> >  static int
> > +rv3029c2_i2c_maskset_reg(struct i2c_client *client, u8 reg, u8 mask, u8 set)  
> 
> I'd prefer that function named _update_bits

I prefer maskset, because that's just what it does. Mask and set.
But well, I'll just change it because it doesn't matter much.

> > +{
> > +	u8 buf[1];  
> 
> couldn't that be u8 buf?

Well, yes. Some other functions do it like this, too. But I'll change
it, because I already did it in a sane way for sr and such, too.

> > +	/* Check whether we are in the allowed voltage range. */
> > +	for (i = 100; i > 0; i--) {
> > +		ret = rv3029c2_i2c_get_sr(client, &sr);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (!(sr & (RV3029C2_STATUS_VLOW1 | RV3029C2_STATUS_VLOW2)))
> > +			break;
> > +
> > +		sr &= ~RV3029C2_STATUS_VLOW1;
> > +		sr &= ~RV3029C2_STATUS_VLOW2;
> > +		ret = rv3029c2_i2c_set_sr(client, sr);
> > +		if (ret < 0)
> > +			return ret;  
> 
> I wouldn't reset the VLOW1 and VLOW2 flags here. Just bail out if the
> voltage is not sufficient. I don't think that condition will actually
> get better simply by waiting.


I do actually think so that we should clear them at least once (that is
retry once). According to the data sheet these bits will not reset
automatically and might be left over from machine start (brown out).

> >  static int
> >  rv3029c2_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
> >  {
> > @@ -230,22 +398,13 @@ static int rv3029c2_rtc_i2c_alarm_set_irq(struct i2c_client *client,
> >  					int enable)
> >  {
> >  	int ret;
> > -	u8 buf[1];
> > -
> > -	/* enable AIE irq */
> > -	ret = rv3029c2_i2c_read_regs(client, RV3029C2_IRQ_CTRL,	buf, 1);
> > -	if (ret < 0) {
> > -		dev_err(&client->dev, "can't read INT reg\n");
> > -		return ret;
> > -	}
> > -	if (enable)
> > -		buf[0] |= RV3029C2_IRQ_CTRL_AIE;
> > -	else
> > -		buf[0] &= ~RV3029C2_IRQ_CTRL_AIE;
> >  
> > -	ret = rv3029c2_i2c_write_regs(client, RV3029C2_IRQ_CTRL, buf, 1);
> > +	/* enable/disable AIE irq */
> > +	ret = rv3029c2_i2c_maskset_reg(client, RV3029C2_IRQ_CTRL,
> > +				       (u8)~RV3029C2_IRQ_CTRL_AIE,
> > +				       (enable ? RV3029C2_IRQ_CTRL_AIE : 0));
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "can't set INT reg\n");
> > +		dev_err(&client->dev, "can't update INT reg\n");  
> 
> I would also put that particular change in a separate patch, with the
> _update_bits addition.

> Ditto.

Ok. This will require a separate patch that just adds the update_bits
function which the tricke change depends on then.

> > +static int rv3029c2_of_init(struct i2c_client *client)  
> 
> I'd name that function rv3029_trickle_config or so. Other features
> parsed from DT can be implemented using other functions.

Ok.

> > +	err = of_property_read_u32(of_node, "trickle-resistor-ohms", &ohms);
> > +	if (err) {
> > +		/* Disable trickle charger. */
> > +		eectrl &= ~RV3029C2_TRICKLE_MASK;  
> 
> I wouldn't touch it at all, some people may set it in the bootloader and
> don't expect linux to change the value.

But that would mean there is no way to disable it once it got enabled.
So I'd rather keep it like this or use special values (like a huge
value) like we already discussed.

> > +	} else {
> > +		/* Enable trickle charger. */
> > +		for (i = 0; i < ARRAY_SIZE(rv3029c2_trickle_tab); i++) {
> > +			elem = &rv3029c2_trickle_tab[i];
> > +			if (elem->r >= ohms)
> > +				break;
> > +		}
> > +		eectrl &= ~RV3029C2_TRICKLE_MASK;
> > +		eectrl |= elem->conf;
> > +		dev_info(&client->dev, "Trickle charger enabled at %d ohms "
> > +			 "resistance.\n", elem->r);
> > +	}
> > +	err = rv3029c2_eeprom_write(client, RV3029C2_CONTROL_E2P_EECTRL,
> > +				    &eectrl, 1);
> > +	if (err < 0) {
> > +		dev_err(&client->dev, "Failed to write trickle "
> > +			"charger config\n");  
> 
> Those strings should be only on one line to stay greppable.

Ok. The line break is a left over from a code reformat.

> > +	rc = rv3029c2_of_init(client);
> > +	if (rc < 0) {
> > +		dev_err(&client->dev, "OF init failed.\n");
> > +		return rc;  
> 
> I don't think this should be a hard failure, the RTC can function
> without that particular configuration, the previous error message is
> enough (no need for two messages).

Only 50% agree here. :)
And RTC without a working backup battery is not really that useful.
But I can remove the error checking of course.

Thanks for the comments.

-- 
Michael

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

--Sig_/2l/I0deTJQiM5JKvEfYjP9D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1g95AAoJEPUyvh2QjYsO/FQP/15yX4LDaposFd3uvHE5ELDc
rKaUEqbC3LhlhyltEanyzw0iFwlNQSDKvjx2qP4UE0ih5olLjGbvIj9j88Mwpwjs
TBdkE3zOmK0Pw9+3Kxc7npIQnCu/b36i+LSMC62b5L0odDhLr+ZChxsPgkFKd06n
Su7JlVidDHMBZ/X4SNJYshMG+RXj11EQpL7ylxvTQYOjoooRBRLl1457OV1IPzuz
Jhfibjrs1f4c98B78CFp4urSVZZVr7XLf73MSNshPYtfVvdovOesL/zX94uBD/JM
8++u6yVpI5n9sBtpnGFL6ZO3tkP4GdWNZvzB3K3MUG24xMepA1fgo5TWLsr4mqDX
nYJzYZp/Ako1JYaikNqrvD8YF3hScJca3wNWTs/k5VnPsYxOF+SoyQvyLOy1HvsR
nEfgHI2h11wRo3DdElzvpz6J4wL9XYoDLGILSXGq1hjgxMKG//uLxI5C/REAGvlb
iZfXD5CjBOsUdKf8qH4D4GF7g7iiBxBB90oD4O812tUGjYkLnMiJfAiMiYKcFxJW
tSdJGieWdO7A2EAD3pcjxwTEyMuOWGVTOzSgeYxHq5GvM2mOF1tHk4uvkrdANh2Y
T2P9rFTOSUxM+Fnfa8ZwLy0jYFKOB2hOSU+LuyPOHaZQfvgCdmEF4582iEBteTGV
uMJp1ec0aU9BP6n1WGDC
=hOwq
-----END PGP SIGNATURE-----

--Sig_/2l/I0deTJQiM5JKvEfYjP9D--
