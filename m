Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C770370D6E;
	Fri, 21 Aug 2026 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308634; cv=none; b=SNnYpMyJA6XyyGf65LLuNokSbDr6qMCVdAGuAvK/JVmCVlWdoCFsPDpd0EaEUPHMxSp8OjxQxlcn5gsNTnVG+48qPZY30nrfTbgS8LkicURgxH+oVGR8foXZxAZBeyKaLEAAgLUlHwFO5LLQ+hoaCtO3hDxXrzs7vQL+1rq1Cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308634; c=relaxed/simple;
	bh=zCscsBoLLm3IYcbhPT7Z/B1c6ayiDAku+pqhdanIq8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dYzAuFiB+aLCm9woIZzsC4W0vB5JG3lOAVYfZyiubp77ocZd8J1RVluDxZhnUj5gqy59xa6dnreASnI6eryudBXNMVPrLEjvdmV8vEFUSZqA6f/nPLMtbNjs5OduXGsA6hsfvDCNxEtcuj8UzaDAX+bbjpFDIZ45WWGGf3guNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgJyKi25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgJyKi25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544741F000E9;
	Fri, 21 Aug 2026 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787308622;
	bh=Ty4c7dx0rrcNYUxNKu46mmG116xzQVjfwXXQdiZwi+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgJyKi25/7HfM5c6Oh2NR6ABzorXElSX0fdZVqNrewKWz+3Vm8yrzRVh87dwXvYjp
	 ueHlaOp2Hc8A3FwNuAFm9Lkd+HVC+KQZ45wKwO0JiwmReBVmAQL7E7vFGrd8WbVOQ7
	 vuiWAcff18nGda55UjY95Kp51VYkCr9m8malWM/xNEuMzEeb+uxHuBWIH60Pq+0MFM
	 Br/UqAp8HWHE5xSSlbN7zmX/Wcb98+HweBQfhhaoIRxgbWH1Ya1zD5l2lll+ideJ0P
	 r915y+hE1MrQb/D3g4aRdI7czvADTdoxea/+xb7c5K5ZZ2CzCRJeHHl/0zlZwnJX6C
	 8zWkvtULVU/kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] rtc: nct3018y: Make sure clk_init_data is fully
 initialized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <6dba18b645aeea279a67f4625d5ec48037c76f0c.1787241693.git.geert+renesas@glider.be>
References: <cover.1787241693.git.geert+renesas@glider.be>
 <6dba18b645aeea279a67f4625d5ec48037c76f0c.1787241693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:37:01 +0000
Message-Id: <20260821103702.544741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmanaged OF clock provider registration causes a resource leak an=
d potential use-after-free on probe failure or driver unbind.
- [High] Missing restore of NCT3018Y_REG_CTRL state on error paths in nct30=
18y_rtc_set_time.
- [High] Data race due to missing lock for read-modify-write sequences on N=
CT3018Y_REG_CTRL.
- [High] Unhandled I2C short block reads lead to uninitialized kernel stack=
 memory being used and potentially leaked to userspace.
--

--- Patch [3]: [PATCH 3/5] rtc: nct3018y: Make sure clk_init_data is fully =
initialized ---
commit 3afc7c4d645666922e04824eeba8803bb2dbf8c0
Author: Geert Uytterhoeven <geert+renesas@glider.be>

rtc: nct3018y: Make sure clk_init_data is fully initialized

This commit fixes a potential issue where uninitialized members in the
clk_init_data structure could cause subtle bugs depending on stack
initialization configs. It fully initializes the structure to avoid
future breakage.

> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> index 700a395fad3a6..2f7ad57057a4b 100644
> --- a/drivers/rtc/rtc-nct3018y.c
> +++ b/drivers/rtc/rtc-nct3018y.c
> @@ -459,8 +459,8 @@ static struct clk *nct3018y_clkout_register_clk(struc=
t nct3018y *nct3018y)
>  {
>  	struct i2c_client *client =3D nct3018y->client;
>  	struct device_node *node =3D client->dev.of_node;
> +	struct clk_init_data init =3D {};
>  	struct clk *clk;
> -	struct clk_init_data init;
> =20
>  	init.name =3D "nct3018y-clkout";
>  	init.ops =3D &nct3018y_clkout_ops;

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak the
clock provider on probe failure or driver unbind?

Further down in nct3018y_clkout_register_clk():

    of_clk_add_provider(node, of_clk_src_simple_get, clk);
   =20
When of_clk_add_provider() is called without a corresponding remove path or
devres wrapper like devm_of_clk_add_hw_provider, it looks like a dangling
pointer could be left in the global of_clk_providers list. If the memory
backing the clock is freed via devres and another device queries the clock,
can this lead to a use-after-free?


[Severity: High]
This is a pre-existing issue, but is there a missing restore of the
register state on error paths in nct3018y_rtc_set_time?

drivers/rtc/rtc-nct3018y.c:nct3018y_rtc_set_time() {
    ...
    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
    if (err < 0) {
        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_SC\n");
        return err;
    }
    ...
}

If an I2C write error occurs during time setting, the driver returns early
without restoring NCT3018Y_REG_CTRL. Does this leave the hardware in an
inconsistent state with the NCT3018Y_BIT_TWO flag set incorrectly?


[Severity: High]
This isn't a bug introduced by this patch, but is there a data race on
NCT3018Y_REG_CTRL?

nct3018y_rtc_set_time() executes in process context and performs a
read-modify-write:

drivers/rtc/rtc-nct3018y.c:nct3018y_rtc_set_time() {
    ...
    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
    ...=20
    flags |=3D NCT3018Y_BIT_TWO;
    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
    ...
}
   =20
Simultaneously, the threaded IRQ handler can call nct3018y_set_alarm_mode()
which does the same:

drivers/rtc/rtc-nct3018y.c:nct3018y_set_alarm_mode() {
    ...
    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
    ...
    flags |=3D NCT3018Y_BIT_CIE;
    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
    ...
}
   =20
Since the RTC core's ops_lock doesn't serialize against the threaded IRQ
handler, can concurrent operations overwrite each other's register state
and lead to missed alarms?


[Severity: High]
This is a pre-existing issue, but could unhandled short reads leak
uninitialized kernel stack memory to userspace?

drivers/rtc/rtc-nct3018y.c:nct3018y_rtc_read_time() {
    ...
    err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SC,
                                        sizeof(buf), buf);
    if (err < 0)
        return err;
       =20
    tm->tm_sec =3D bcd2bin(buf[0] & 0x7F);
    ...
}
   =20
i2c_smbus_read_i2c_block_data() returns the number of bytes read on success.
If it returns fewer bytes than requested, the remainder of the stack buffer
remains uninitialized but is still parsed into the rtc_time struct.

Can this uninitialized memory then be read by userspace via the RTC_RD_TIME
ioctl?

The same pattern appears to exist in nct3018y_rtc_read_alarm():

drivers/rtc/rtc-nct3018y.c:nct3018y_rtc_read_alarm() {
    ...
    err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SCA,
                                        sizeof(buf), buf);
    if (err < 0) {
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787241693.gi=
t.geert+renesas@glider.be?part=3D3
