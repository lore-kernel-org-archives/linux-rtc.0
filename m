Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706540961C
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190673; cv=none; b=uc2gdSKC4apqLKEEbVLsxtKPK7M1n8kHz+yhQqRAJE30rUgK9NEALzGxaSaNJfPJvhx5UvARutYiodzKcIA+1CVGM1d3pW3kQLCXzTzbfcifSGXA+J2oT2psoiez1uoKx53NvtdvKwRUSL/pxbeR6MfdCFJHexEfQD0PT2HaUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190673; c=relaxed/simple;
	bh=spS4amaSUghfoWNYKzXULKMkyw8l6kQ3ygu1F5jo+UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtBeHw1TOJk2A9TBE/S8Wzyj0aiaelD/LsxbKDCJ2KpeIkqtbfKsbTVH6lJwx2cyFzeh1PEc3KRYGrni3w2dR7tea3U351Ih1gf9UrJomKh3FF9Rp/8SkLDdbe2DJcD7DtzV6y36VJ6ZHfhPl5CLjfgpucuIO/ubRsp31hX0kYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJFklZvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJFklZvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0CC1F0089B
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190672;
	bh=spS4amaSUghfoWNYKzXULKMkyw8l6kQ3ygu1F5jo+UI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AJFklZvAYuO3wcG1bgghY0fve+Nn3UXIumMwC/7HczhV6TLIhrWip4V1Oz+G/qb8l
	 S2x4JdLpXyBRYiPNLidktohdQ52Ug8rahaAcHyIs6o/FemWl75ts4lSk5hRGjbWCq5
	 aPvAamnklx0KtRWOnUB5gYNAovHQ8fci9DyfCEwrZaUnXfKT9d/VwNQO+KqwGKmdlH
	 Qix1TTJ2CJuPSSyyKMBuy9nF1vX7R6eZ1oade4DuedaJcxGXmSONRy+tElslyubpQo
	 zoNFptN51mHNBUEntO7QkDIltnnVXi8NYfmLUfcwCdyVRbf+LPZLMSNdxKaW4RAkib
	 y7gLP+XyANzlA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a77da28307so14163391fa.1
        for <linux-rtc@vger.kernel.org>; Mon, 05 Oct 2026 01:57:52 -0700 (PDT)
X-Gm-Message-State: AFq9FYI0yTZAxaMnP78A4eh3HMMe3RADeFcKCoVj2RfFyKBNd6dCOLJn
	I0wLI+E6yzum1Y8cc5zKPJQ5mzO4IaAgOsR0glLESSCdSMH9tYi1sR+QxmpvHTRAjIzHuN7GWEu
	N6RnWSMWsCaWMX5Z6ro2vSaBcpRFJx58=
X-Received: by 2002:a05:651c:15c1:10b0:3a9:8546:ee13 with SMTP id
 38308e7fff4ca-3a98546efc0mr5211731fa.19.1791190671011; Mon, 05 Oct 2026
 01:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004220258.401706-1-rosenp@gmail.com>
In-Reply-To: <20261004220258.401706-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 10:57:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLnMiTqjncmFLR8E4yE8NPcCCmi2sDOviePSLf+ugt_wAA@mail.gmail.com>
X-Gm-Features: AclHuK848ZkRY_JRmLDz5eE9XGs4RhJPpRikOgh1I8H5_6NBEypIA9x9lrT6SVA
Message-ID: <CAD++jLnMiTqjncmFLR8E4yE8NPcCCmi2sDOviePSLf+ugt_wAA@mail.gmail.com>
Subject: Re: [PATCH] rtc: ftrtc010: use devm_platform_ioremap_resource()
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:03=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with devm_platform_ioremap_resource(), and propagate its
> ERR_PTR() directly.
>
> This also reserves the MMIO region. The only user, gemini.dtsi,
> describes a single 0x100 window at 0x45000000 that no other node
> overlaps, so this introduces no conflict.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Looks good, thanks Rosen!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
