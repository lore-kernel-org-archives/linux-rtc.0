Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374973C8719
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685965; cv=none; b=Wc+7V0kbTGNoGlg0FeCDFkSwT7wifjsAc/iYkc9eZkguOCGk/X9W1tbKQyU55uXkDrBz540FyT/AJLWZVwG3I6vuRW5Pw3we2giPKAPgl5OOZzHtGlgLQT46XdMRWMVIecvwi1M640rnf3ubIGLmCO4VwKlGFfwWbKofYfIo9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685965; c=relaxed/simple;
	bh=TZi4HKfQec5mJg0OSAq5UIF887Jvq7V+NdZvcDWQnN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARytT4H2wVQ2juTtcSqdZQJKJ+OjSgQog0zHkrIY6zrQsf6253qXJps3N8aa/AcbJUeC82RXYzXN3K+lYQSuWKS1f/fCl+2YvNID2m6ADXFGaR+ymfws8t9ydmf+cFv0rPx0fWOhlGPK0qXen2dWHLu9gfWPqfQSALCu6b1Kyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTZ0txGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTZ0txGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4E71F00AC4
	for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787685963;
	bh=TZi4HKfQec5mJg0OSAq5UIF887Jvq7V+NdZvcDWQnN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WTZ0txGA8d+fAOU2fnhnfN52rNuyY4zGAKYyoeFz/7f154D7g4hQk8VPtl0es0X+q
	 YNk9ds/1oReWw0XYC2QN7BNkisWddvR7j0QJ9VTHI7GN7wgtLa2ubj1YW+f1YT5Fiq
	 6g5ZPUAkugvKWPZ12MnUyBy0KNQWtn+aNPxy7K5diqPG9VtvgiKQ5WXnKmr2/S044F
	 6siBqNreloq7rbWzZA1iiHDRv8/yj+XQDnq6V5A9QpOv5dFjbq0d1oeq9d7DT0Zlbv
	 33fQc6PQrwzrFo07Q3VWsxOyct0d/RZSISbVZ/JZcyDHDWTF2LdxGqBgwVE5ZE1a89
	 nZsbXWOHHzS7w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b4740ec30cso85293e87.3
        for <linux-rtc@vger.kernel.org>; Tue, 25 Aug 2026 12:26:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrh+3xYITjFceicc0EHJxUjMSaae2wWrIEQwBNffQGf4TllXwBXVJP23t4dcY2Quz6c9ioDEg/N+e0=@vger.kernel.org
X-Gm-Message-State: AFuF++nAzonm90b6Gx86nIpoFSb6oNv/WX1K1fsVtFa1/RoFxUcwAn9q
	qZvQqvnrukHhkfoXOnjxNIa7+jouwzD0aDJpd5wMcXbVos0wr1F+7qxE4PpCoJvH2DQOhKPfX1W
	rKygcQqf+rEH3DSFBfZ6/Ik7O/D52+E8=
X-Received: by 2002:a05:6512:10cf:b0:5ae:b969:417d with SMTP id
 2adb3069b0e04-5b4a8e672f0mr179895e87.0.1787685962230; Tue, 25 Aug 2026
 12:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-2-df96569e3412@posteo.de> <20260823222159.BC7671F000E9@smtp.kernel.org>
In-Reply-To: <20260823222159.BC7671F000E9@smtp.kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:25:50 +0200
X-Gmail-Original-Message-ID: <CAD++jL=XYORtOX+WSaRrCeRFtgk6OFumit_NorZsSAmpzTAFmA@mail.gmail.com>
X-Gm-Features: AcwNN1WfjFzSm9AUG-vuNR5ZbIeDurE5ElWUy0S5hpdrHd_laBXxACDG3XLgm6k
Message-ID: <CAD++jL=XYORtOX+WSaRrCeRFtgk6OFumit_NorZsSAmpzTAFmA@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] rtc: s35390a: Add missing newline to dev_err
To: sashiko-reviews@lists.linux.dev
Cc: Markus Probst <markus.probst@posteo.de>, robh@kernel.org, linux-rtc@vger.kernel.org, 
	conor+dt@kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 12:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> Pre-existing issues:
> - [High] Probe clears power-on clear (POC) and battery low (BLD) flags wi=
thout acting on them, causing silent data corruption.
> - [High] RTC_VL_CLR ioctl performs a full hardware reset, destructively e=
rasing the RTC time.

This is the single most annoying facet of Sashiko right now, and this
cannot see the forest because of all the trees quality its reviews have.

Why on earth would be be interested in these pre-existing issues
for a patch adding a newline to an error print??

This has to stop, pre-existing issues must at least have some
relevance to what the patch submitter is trying to solve.

Yours,
Linus Walleij
