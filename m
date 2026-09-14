Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24541BA69
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377244; cv=none; b=W1ufZiF2NbF6dRN7EsfIPiWA9okt66paA2VXjK7li6vIHt2tyywrmZIn73K9WZuWtNj8NMLA1JGXs9vlcu8sfr2PkLnhncEGw0JdWLtlgovUtJv8kq4TttWMBvuOdEndoGGcjUGogHy9jX8fcMiV2xC10RNPtz42PxqJ0iyfkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377244; c=relaxed/simple;
	bh=E60LrvOv4D6snvC45CyzXp/jFjIhoVrxockG8xseI20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFr+fVv2ZmjF/Pb7uhx50SStWpK0lP8tMktXxjzjpi8x5U5goZ1ZN37IASurV859qoctsoDla8FY2Qdm0fJ3fcEm3iJeIxBoXoIBSXLIafmxnolDghy3iGwXfQnD1ZmYmcy84DAVycKiziv3nvFhrpTduhD5jE1U0UAEqQ+kLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm2MzbI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm2MzbI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEAB1F00893
	for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377242;
	bh=E60LrvOv4D6snvC45CyzXp/jFjIhoVrxockG8xseI20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fm2MzbI8O1p1YDT3P0pO9ERFq9dng0XQGb1URkQIreCUz+GolSrzbqubj1wPAhYYQ
	 KCmLdva0sbLLsw2QTIc9UYRbzCBsZjFbb7ieHJO6YoEiznFrsBOR/lV7laaC/h7wNQ
	 iFRk9jAqSWA9ilZVtHJkG5Z94tgYd0KZhlqY8wxmjlemK4cw85ZeasApQ6AQRVO8+x
	 gI1lA70L0Jz+bfIGcaiWZREdzxcYnRog4cbFQmNV2qCO1vNQ8jl7biu7IRI1uC6ew7
	 7P+jWWvenF5dU5lghhzlbuVjEIWish3MJPbQG491CbVODTPinhVrAk0+6OgFHMblAn
	 BTp0ajrc95hAw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d77so2013229e87.0
        for <linux-rtc@vger.kernel.org>; Mon, 14 Sep 2026 02:14:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPgPz5JYE/6frxCV8RDXIzDxaKrSr3lHmbTTqmdRXYcqeb6sYwJ0bMQm7G+f+6QobDFVQ+UZX323U=@vger.kernel.org
X-Gm-Message-State: AFuF++n0SW+2VOD2IiANfJk4QXnr+qvcKZwzCBVFonQXYAwXxaB2Dyp9
	GNeCr+xas8UftBkSNMJsolDcmqQ9qVRESRXvt7yPpgAzbOuBs+8MNYONcm65eFbz5bCGzHg017+
	sd9v9dHzrwIN2Mc3NDBMYTgoLaZ4c0pQ=
X-Received: by 2002:a05:6512:3d0d:b0:5b6:1a7c:2c with SMTP id
 2adb3069b0e04-5b8ae6a0873mr414530e87.47.1789377241283; Mon, 14 Sep 2026
 02:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de> <20260831-rtc_s35390a_int1-v8-5-dac1dc86ce1f@posteo.de>
In-Reply-To: <20260831-rtc_s35390a_int1-v8-5-dac1dc86ce1f@posteo.de>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 11:13:48 +0200
X-Gmail-Original-Message-ID: <CAD++jLkBYVGL+oXXXMq+5F2WF31xiGD5FoxDGuNFgd5fawEQOA@mail.gmail.com>
X-Gm-Features: AcwNN1X_Dc3msIppmUpYmdtPkP3lWlbat9n-DuEEQJTnY1Fsv98a0DOXarp0_cs
Message-ID: <CAD++jLkBYVGL+oXXXMq+5F2WF31xiGD5FoxDGuNFgd5fawEQOA@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] rtc: s35390a: Add pinctrl
To: Markus Probst <markus.probst@posteo.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Michael Langer <michael.brainbug.langer@googlemail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:42=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:

> Allow configuration of pin functions, including:
> - keeping the previous configured function
> - disabling output
> - waking up the system
> - minute periodical interrupt (1: 50% duty, 2: 7.81 ms)
>
> If no function has been configured, fallback to previous behaviour.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

This looks fine to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
