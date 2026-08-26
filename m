Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45093AA19B
	for <linux-rtc@vger.kernel.org>; Wed, 26 Aug 2026 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729479; cv=none; b=Udd/pOcZiMCjC5CKkCXuPhpNvJrtcVS0SEf7LE3A19A5Z8/UxONfPR5F2RFB8PpMAVHdHwAlqIo2Wo5B44hPODItkiMSM6A5ShwJptL2zJm5b7SMs6mnQ72GfI4+NA+r3qs6MY7AmNJQ94n6dfFZHmWnPtqJQ2te68I9s8EJSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729479; c=relaxed/simple;
	bh=UohQG3YwY7lOUlVvLWVbLdpHlpUH7ltj2uEVv6bI+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+LR9Q9CPma3hfWZC1C0rvxi1ozpQmFXJGQ2kAo3k5hEHtCXHLXn3y7l3qFGZcosqPGlnrdjMEysR/dX45/xkQE+z9Zjes217z6JoXTg1q7dasnTrRyGqQkN+zW3blD0zw5WbX7evWAGKYPWulqoQZenBtowJvPK0bQdRZTV3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSd6aJ6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSd6aJ6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A261F00A3A
	for <linux-rtc@vger.kernel.org>; Wed, 26 Aug 2026 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787729475;
	bh=UohQG3YwY7lOUlVvLWVbLdpHlpUH7ltj2uEVv6bI+M8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GSd6aJ6jPiK9yOmuMVBRtHLJnMkTQMo7Z2Lkdpr7VUKDR/IgoIiETza0DlIcd4yPY
	 bd+pq1Cz+XdmZOCqKXNxRw/LRnF2H7PPGiX1pJjH/V801dPBhcWmkdQJZBi2BPGlM4
	 yxItF9F/wezIF6j3tUnrbPDdQxXSqvJDZOZutIyaFA4CF4WdFtvIT+zZ32LuOSVsWE
	 +EVRnQHZk/3GL80kOMxH4DrcN6RKYKWhDvwSnysvg0XuS/ue8R57nLr2KOoZZ/Qe4E
	 vbOirOf/lF8KOo+WyunYkHzhqAY97G+alrjTvfVZTwPZmFYTn2kKXch5VR7GeFlMDX
	 tKznCI8uuV1QA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b29599b81cso577531e87.1
        for <linux-rtc@vger.kernel.org>; Wed, 26 Aug 2026 00:31:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoL2Q2VO7F0kbbp86znFnPzjajfgxQ/xt3QxyoxG+mhxiLaYlWLqD0mzsTNFHwhZCQozaF6PLswAdo=@vger.kernel.org
X-Gm-Message-State: AFuF++mCb/Mx+rXiz06l442vU1yyLWFWchYPvHY/hK1xIAr6aDbIE420
	aZVol6ZLb2/l+tWkAKA98m8Bnul6qIuByvVScwWsWTKvJTW1igjVSS0ScXusgCMVVdE0lxLpfa+
	24b6OolSsSg+yk1ajkpyVhM79gHUmpd8=
X-Received: by 2002:a05:6512:3b29:b0:5ae:a0b4:5013 with SMTP id
 2adb3069b0e04-5b4a8d700fcmr1189934e87.0.1787729474161; Wed, 26 Aug 2026
 00:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-5-df96569e3412@posteo.de> <20260823222611.B176B1F000E9@smtp.kernel.org>
 <CAD++jLnpzMs5h-k49HQ_asppECRMm1wGQK8X+vTmiC+S70fZgw@mail.gmail.com> <3827a4e6be868e8726c140281a140a85e706aacc.camel@posteo.de>
In-Reply-To: <3827a4e6be868e8726c140281a140a85e706aacc.camel@posteo.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 26 Aug 2026 09:31:00 +0200
X-Gmail-Original-Message-ID: <CAD++jLm1fU41_gY+CUZpS+woURECAqdy3PEiV+_+g4cnL7rciw@mail.gmail.com>
X-Gm-Features: AcwNN1U59KN6awAelPsuYmcuHtZlNIrj9X52ZAxwkc3wLZaZ-UfIl-H65G2LfEw
Message-ID: <CAD++jLm1fU41_gY+CUZpS+woURECAqdy3PEiV+_+g4cnL7rciw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] rtc: s35390a: Add pinctrl
To: Markus Probst <markus.probst@posteo.de>
Cc: sashiko-reviews@lists.linux.dev, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, 
	linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:37=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:

> > > [Severity: Medium]
> > > Is there a data race here since the pinfunction array is accessed loc=
klessly
> > > after pinctrl_enable() has made the pinctrl device available?
> >
> > That's a valid concern.
> I don't think so.
>
> `s35390a_pinctrl_set_mux` itself will take a lock for the operation.
>
> `pinfunction[i]` is a 32-bit integer, so there should be no load
> tearing.
>
> If we take a lock here, it shouldn't change anything. In a normal
> condition this shouldn't happen anyway, as `pinctrl_enable` should
> block until the default state is selected. If another driver is
> concurrently selecting a pinctrl state of this device while we probe
> (which is the only time pinfunction should be modified here
> concurrently), it is still a race condition whether the fallback
> applies or not.

I buy that.

Once there is a solution for the Kconfig business I think
this is good to go!

Yours,
Linus Walleij
