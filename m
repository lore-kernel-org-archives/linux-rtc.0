Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B3439F63
	for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737733; cv=none; b=Cvq745ggsdIBjDaNugkXtCCvbQ0qILtjaOstfYbEER80NSZE5t2w3iVdiPvek7fYWnZMAlDC7PDqbbj4+02AlbZk8HLofrYeDPSNokQV9hviau/NHXz/+OantfuJAQOqKKSg/qmKgYxJgX8pdyU/rnVRwUN9XZ45ZU+SeQi8nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737733; c=relaxed/simple;
	bh=SgrI06VkRvOUZZO0DVjTQu+oEWa6QEs25v+7RLbBZmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KVDS48cspU9tQpuZ6duNn9WLrG/uo0PEVslNYq5LVzfYa374E9LNNSr7N2au9JIZhHZbged2eUFmtWFZVvO6248QEFcM/5vf+V890yhgEP/QKG7jsg2kFFz48O5UtsRgFlRrW5Xb2pFrnPkO+6DGPNofGux/v8cFMFuY7obyGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UfuUQ8wh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UfuUQ8wh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de008b020so4778035f8f.1
        for <linux-rtc@vger.kernel.org>; Wed, 22 Jul 2026 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784737727; x=1785342527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0VgoN131mpCFDGVLEaTpJh9JaIowTJ3l5BSSOdIVGp0=;
        b=UfuUQ8whqYe7NpyuoRx+Ng2DMxZFzskibozxrSTWyf9a//k45i+60ciBqta7WfG5P4
         AyalqTZ5A0ZSSJBYujhkQqwPZiB4LMpRc274Y+iqIuHV8eaHiWhMIcDChnqESG2+tNGd
         jKG6K2dorhfL/nshV94A4h8f4qHQkP22J4xt+Hbu1hy7dVukX6rSGOMpqrKZtCW+5/GA
         fGL8GSzmWm9zaccA5f9D3gv0UFofpAPyMLYrOLqkN7Uqi3MXzgeaIYbXoZEm1jaJSZbC
         Y0h/DWlYZNwvobOL6wz0yOU2qpB9NfoTkVEN5l6kluNnK5hb7CUcMHDMCaRwV0IuieL2
         dtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737727; x=1785342527;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0VgoN131mpCFDGVLEaTpJh9JaIowTJ3l5BSSOdIVGp0=;
        b=BHANS3anQ4KPdhnDsy24a2UJD9WW7HfSiTt2VMGaaD8ZxsYFsLjsikB4XCsY55qqw+
         RBm+ZE4aNAsq+4zZkkpBYEDIu6UDE7W6vHS1zh4EIi4o12gDT+I1JKWxKzzhfrWvOTYu
         gF/G4iSNgxyLfYmXhxvLfr/hwBBtaFjf/HHp4Zler8ayWYjj1jCjeQiShtFB+nK//LY0
         T8PmTdkDNT//snnntVMNk5UK14goViXBuJdc5iLD5f81I9LCCL3WZ7EVQcPrYyli2wYP
         yuheqH0YU5nxyejErLkyvzCNR2KO98EEzOx2zMiRstY/YzUYtlvpcpTUhS7z6bwT6Gx0
         S9tg==
X-Forwarded-Encrypted: i=1; AHgh+RqGf2/R7uemiP7D5t4cqpSaIBALlUFlmjwr9XXwd4NuhXfgp92iDp1UIRnDXnCaKY3MHWyQK7oWRlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvsDL+zLPsk1Kk8DtpWOVoVfodjkmXvQFSQdamKXvEP6VuC7JF
	28cCmVpNwLLHACy/woOE4QtSrgDRgWoxkzNpNoew6/wyBNhDLCHClrmNfOuo6F8RBtw=
X-Gm-Gg: AR+sD13fTaGjY4uL6NKZrz6/PavMEJKtLxZ0HZqxwxEUXx3VYWP96rVaxKIDwszWW26
	wAtdlNRHgw+wiU1gvghWTNQWs7V3zcE9wxCJTUAeHL+XPCxiRDva1WT/TPWSxaiCVfr4/iatC2O
	TV9qlGCTfuuhcsRIM3TlM7UKDX01qHbq9SPQyMR+QFm5yickfak0hqxVMHXiFmG2PmJLND2B4UP
	YLHtkOIf2w3BfA7UoKbNzd7jtaUIF0TsE1QXO2Yr2Jln3la/IRYWtxXGsJuKElKeVnKmC3Mr5Kf
	Kz8QQcNlSZ6mGqyjqFKO6pjgcUTqTu9BFwK3c7Qqwrt91EKs6TWiBVaFb8kWgXfhsUwEBJY0UYQ
	2ilG/4l1mUelO1HDkvdi8mNnU0hQbXYarB9L+25oUGpXwc8x1z/tSoXCZmzFVA9tp+/DbHaiQhf
	M/
X-Received: by 2002:a05:6000:4383:b0:47f:8a78:e814 with SMTP id ffacd0b85a97d-47f8a78e864mr1966333f8f.9.1784737727656;
        Wed, 22 Jul 2026 09:28:47 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:3382:6663:1606:b6ac])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85c6d277sm7563000f8f.32.2026.07.22.09.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:28:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Maxime
 Ripard <mripard@kernel.org>,  linux-rtc@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org,
  linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 2/4] clk: sunxi-ng: div: add read-only operation support
In-Reply-To: <CAGb2v64HjXygw76zaNi9KaG-zfc+hZoeyp4EHyz68fcdK-AXNw@mail.gmail.com>
	(Chen-Yu Tsai's message of "Wed, 22 Jul 2026 23:40:07 +0800")
References: <20260722-a733-rtc-v6-0-631cca28cc9a@baylibre.com>
	<20260722-a733-rtc-v6-2-631cca28cc9a@baylibre.com>
	<CAGb2v64HjXygw76zaNi9KaG-zfc+hZoeyp4EHyz68fcdK-AXNw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 22 Jul 2026 18:28:45 +0200
Message-ID: <1jse5bc7k2.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On mer. 22 juil. 2026 at 23:40, Chen-Yu Tsai <wens@kernel.org> wrote:

> On Wed, Jul 22, 2026 at 10:48=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.=
com> wrote:
>>
>> Add support for sunxi-ng read-only dividers. This will be
>> useful to the a733 oscillator detection logic.
>>
>> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/clk/sunxi-ng/ccu_div.c | 31 +++++++++++++++++++++++++++++--
>>  drivers/clk/sunxi-ng/ccu_div.h |  1 +
>
>>  drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
>>  drivers/clk/sunxi-ng/ccu_mux.h |  4 ++++
>
> Left over stuff?
>

Argh indeed, that's no longer necessary=20

>
>>  4 files changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_d=
iv.c
>> index 62d680ccb524..c385e0160f13 100644
>> --- a/drivers/clk/sunxi-ng/ccu_div.c
>> +++ b/drivers/clk/sunxi-ng/ccu_div.c
>> @@ -20,8 +20,22 @@ static int ccu_div_determine_rate_helper(struct ccu_m=
ux_internal *mux,
>>         if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>                 req->rate *=3D cd->fixed_post_div;
>>
>> -       ret =3D divider_determine_rate(&cd->common.hw, req, cd->div.tabl=
e,
>> -                                    cd->div.width, cd->div.flags);
>> +       if (cd->div.flags & CLK_DIVIDER_READ_ONLY) {
>> +               unsigned long val;
>> +               u32 reg;
>> +
>> +               reg =3D readl(cd->common.base + cd->common.reg);
>> +               val =3D reg >> cd->div.shift;
>> +               val &=3D (1 << cd->div.width) - 1;
>> +
>> +               ret =3D divider_ro_determine_rate(&cd->common.hw, req, c=
d->div.table,
>> +                                               cd->div.width, cd->div.f=
lags, val);
>> +
>> +       } else {
>> +               ret =3D divider_determine_rate(&cd->common.hw, req, cd->=
div.table,
>> +                                            cd->div.width, cd->div.flag=
s);
>> +       }
>> +
>>         if (ret)
>>                 return ret;
>>
>> @@ -143,3 +157,16 @@ const struct clk_ops ccu_div_ops =3D {
>>         .set_rate       =3D ccu_div_set_rate,
>>  };
>>  EXPORT_SYMBOL_NS_GPL(ccu_div_ops, "SUNXI_CCU");
>> +
>> +const struct clk_ops ccu_rodiv_ops =3D {
>> +       .disable        =3D ccu_div_disable,
>> +       .enable         =3D ccu_div_enable,
>> +       .is_enabled     =3D ccu_div_is_enabled,
>> +
>> +       .get_parent     =3D ccu_div_get_parent,
>> +       .set_parent     =3D ccu_div_set_parent,
>> +
>> +       .determine_rate =3D ccu_div_determine_rate,
>> +       .recalc_rate    =3D ccu_div_recalc_rate,
>> +};
>> +EXPORT_SYMBOL_NS_GPL(ccu_rodiv_ops, "SUNXI_CCU");
>> diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_d=
iv.h
>> index be00b3277e97..a30a92780a05 100644
>> --- a/drivers/clk/sunxi-ng/ccu_div.h
>> +++ b/drivers/clk/sunxi-ng/ccu_div.h
>> @@ -300,5 +300,6 @@ static inline struct ccu_div *hw_to_ccu_div(struct c=
lk_hw *hw)
>>  }
>>
>>  extern const struct clk_ops ccu_div_ops;
>> +extern const struct clk_ops ccu_rodiv_ops;
>>
>>  #endif /* _CCU_DIV_H_ */
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_m=
ux.c
>> index 4503c9780c39..12bfc99c9172 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.c
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
>> @@ -67,7 +67,7 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu_c=
ommon *common,
>>         return parent_rate / ccu_mux_get_prediv(common, cm, parent_index=
);
>>  }
>>
>> -static unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *c=
ommon,
>> +unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
>>                                             struct ccu_mux_internal *cm,
>>                                             int parent_index,
>>                                             unsigned long parent_rate)
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_m=
ux.h
>> index c94a4bde5d01..272a2c36a8f2 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.h
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
>> @@ -134,6 +134,10 @@ unsigned long ccu_mux_helper_apply_prediv(struct cc=
u_common *common,
>>                                           struct ccu_mux_internal *cm,
>>                                           int parent_index,
>>                                           unsigned long parent_rate);
>> +unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
>> +                                           struct ccu_mux_internal *cm,
>> +                                           int parent_index,
>> +                                           unsigned long parent_rate);
>>  int ccu_mux_helper_determine_rate(struct ccu_common *common,
>>                                   struct ccu_mux_internal *cm,
>>                                   struct clk_rate_request *req,
>>
>> --
>> 2.47.3
>>

--=20
Jerome
