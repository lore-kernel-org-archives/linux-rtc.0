Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B63DDB19
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343384; cv=none; b=dO4iEDxXuAgJQ8HPWgk3JVN+0+zLLFFgqcGJUvi9+6Ff7RQ2GtNzEwdIUSSoI1Js16lQ+/1kzsj33vydioKtiIBVuFYZIgnDyQUEqOVKA93IyS7BVVHyWKF6KjdJ3ccLADLyu+Cp41yIdrIwKrkVNtyhOMTysHl2cDWF3kKzB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343384; c=relaxed/simple;
	bh=m6vNbfcTFMDJTCUe+imERKqcuZmnxBqvDavG7Tef+eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wx8RuDTKConfpGAaNQlCLbqq+UKkG5LgfnVer3XYDvbbrbJIXIigTyrWm3gTrrB4Zbo/fwUc01jKgKsfgihp/t0mTUXBTcTkZ1677SAUR17ePWCsUg4FwsEn6+GlMELwekIdyLSPRvQVK/LmVv6H/p2SvxSfPC0znZu2zILc78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuUNI0AC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuUNI0AC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D793B1F000E9
	for <linux-rtc@vger.kernel.org>; Mon,  6 Jul 2026 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343382;
	bh=oSBhOhh94uibX703mDFvpSfIFzkXKtVz7iv2dM/6XNU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=HuUNI0ACGV0hFdp9b5p71SvVJUhi5QvaIx0aoDsqt/lkBppKO9pgYOLNy3gW8+WNs
	 7exgxFXSCKSbUgguasUelySxa2qGviIb7b0d6Se5Ck92Ved/AX1cNgdeJ3TlX7Z51+
	 mruAPAcmjCBDIbXoYu8jIoFndCZGcRj1ri0bZxA66TOv7uW0TfzBkQP7eRfOlJ+Nfq
	 kN7zALCWQ5r0yAghI0h1kzDs+lb3P1mTUOkUUy9Iwv1ZHp0ZPyGefUjO5rgAU55PWO
	 uN3/fLRLse/ehFcKC64EpLPraydk78cci4cPSJGnUyrxpMFRnuOoabnz8YeQirDdmM
	 CvnmyEUWqJAhQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aebd77cbb4so2534773e87.2
        for <linux-rtc@vger.kernel.org>; Mon, 06 Jul 2026 06:09:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqmzQe8+8iZgRMWNW+GuTlSPa2fgRh+AuFL4hfJmEerdLiHs/bY78FUkl9rhSe16fv+3sU9HGvv4sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLwQd5qppXCqM3O/weIh9P0kJbe/EHxK4zIzf0Ab5FwhplDtN
	WqVKEGAJyz/qY/Q4Yp8VZDTOGVqIyVMb4gxaKcms/ytgdyYMJ3fhzj3xGC2e/EUlSyF7EHzDQoK
	TB4eC8EV40H5f8bhfrZZMGwoXawcsGmU=
X-Received: by 2002:a05:6512:61a:b0:5ae:9b04:dbb0 with SMTP id
 2adb3069b0e04-5b007bbcfffmr78794e87.0.1783343381196; Mon, 06 Jul 2026
 06:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-6-f330728db3d3@baylibre.com> <20260706100635.E5DC61F000E9@smtp.kernel.org>
 <1jv7asguqu.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jv7asguqu.fsf@starbuckisacylon.baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 6 Jul 2026 21:09:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67zgADhe+PG4UJke0r-1eQrXKhZ9PbqWfY9JNZ8cBxMeA@mail.gmail.com>
X-Gm-Features: AVVi8CfXtsQWXmbgCdreOulPhQzwv9AjubtuzL3ZucIy6oiHmmXq6hOpzzZI_Bk
Message-ID: <CAGb2v67zgADhe+PG4UJke0r-1eQrXKhZ9PbqWfY9JNZ8cBxMeA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] clk: sunxi-ng: div: add read-only operation support
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
	conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:36=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com>=
 wrote:
>
> On lun. 06 juil. 2026 at 10:06, sashiko-bot@kernel.org wrote:
>
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Inconsistent rate calculation between `determine_rate` and `=
recalc_rate` due to division order.
> > --
> >
> > commit 39f872462c04ad724c3624b152234160de56a47e
> > Author: Jerome Brunet <jbrunet@baylibre.com>
> >
> > clk: sunxi-ng: div: add read-only operation support
> >
> > Add support for sunxi-ng read-only dividers. This will be
> > useful to the a733 oscillator detection logic.
> >
> >> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu=
_div.c
> >> index 62d680ccb524b..d1c8c7baa12dc 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_div.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> > [ ... ]
> >> @@ -84,6 +84,36 @@ static int ccu_div_determine_rate(struct clk_hw *hw=
,
> >>                                           req, ccu_div_determine_rate_=
helper, cd);
> >>  }
> >>
> >> +static int ccu_rodiv_determine_rate(struct clk_hw *hw,
> >> +                                struct clk_rate_request *req)
> >> +{
> >> +    struct ccu_div *cd =3D hw_to_ccu_div(hw);
> >> +    unsigned long val;
> >> +    u32 reg;
> >> +    int ret;
> >> +
> >> +    reg =3D readl(cd->common.base + cd->common.reg);
> >> +    val =3D reg >> cd->div.shift;
> >> +    val &=3D (1 << cd->div.width) - 1;
> >> +
> >> +    req->rate =3D ccu_mux_helper_unapply_prediv(&cd->common, &cd->mux=
, -1,
> >> +                                              req->rate);
> >> +
> >> +    if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >> +            req->rate *=3D cd->fixed_post_div;
> >> +
> >> +    ret =3D divider_ro_determine_rate(hw, req, cd->div.table,
> >> +                                    cd->div.width, cd->div.flags, val=
);
> >> +
> >> +    if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >> +            req->rate /=3D cd->fixed_post_div;
> >> +
> >> +    req->rate =3D ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, =
-1,
> >> +                                            req->rate);
> >
> > [Severity: Medium]
> > Will this division order cause inconsistent rate calculations compared =
to
> > ccu_div_recalc_rate()?
> >
> > The divider_ro_determine_rate() helper applies DIV_ROUND_UP() to the un=
adjusted
> > parent rate, and then this function divides that result by fixed_post_d=
iv and
> > prediv.
> >
> > However, ccu_div_recalc_rate() applies prediv to the parent rate first,=
 then
> > calculates the divider rate, and finally divides by fixed_post_div.
> >
> > Since the Common Clock Framework requires determine_rate and recalc_rat=
e to be
> > mathematically consistent, could this discrepancy cause rate mismatches=
 or
> > warnings for clocks using a pre-divider or fixed post-divider?
>
> I think the RO side is correct and RW one is not.
>
> The RO part correctly walk back the tree by un-applying the predivider
> so, whatever CCF does with the parent rate value will be correct.
>
> The RW part query the parent rate then applies the prediv. This
> will be thrown away when/if clk_divider_bestdiv() calls
> clk_hw_round_rate() on the parent. If that happens, the subsequent
> un-apply of the prediv would make the matter even worse. So (if I
> understand all this correctly) this case does not happen yet, otherwise
> we would have noticed, and it can be fixed separately.

Looking at the history, ccu_div_determine_rate_helper() used to be
ccu_div_round_rate(), so it wouldn't have tried all the parents. Looks
like I missed this when looking at the conversion patches back in
January.

The fix is easy though: just reimplement divider_round_rate_parent().
Somehow we did this already for the multiplier but not the divider.

BTW, would it make sense to implement ccu_rodiv_determine_rate() using
ccu_mux_helper_determine_rate() as well? That would make both RW and RW
consistent, but it would mean another rewrite for you ...

> Side Note: I've not followed the sunxi history behind all those
> prediv/postdiv but I find them a bit confusing. It seems like inserting
> some fixed factor clocks in the clock trees would accomplish the same
> thing while simplifying mux/divider quite a lot by droping these quirks ?

I think the whole idea was that we didn't want all those extra intermediate
clocks. If you look at drivers/clk/sunxi/ you can see that we came from a
one device node per clock design, which was messy and bloated. The second
try ended up being the "one clock per useful hardware clock unit" design
you see now..

And we somehow tied the list of clks to the exported list of clks,
which probably made it worse for adding intermediates.

> Side Note #2: I feel that while sashiko is pointing out valid things but =
we
> are slowly getting off topic and down the rabbit hole with it ...

Yeah. That's the downside of Sashiko.


Thanks
ChenYu
