Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475F3E8686
	for <linux-rtc@vger.kernel.org>; Thu, 28 May 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974557; cv=none; b=YTUCW5qsb+UCd6YYIIpdXlECaJ+dhxgRNNw3kaaJMhRqomvtfSVjxd2rXJZ6/JsdTC0acZVuyw7p7yz/2fYvpjglpOJl+6EFaNa2lSG2FFOWFr582AvLWPjPUVjs5z1IP13Yc2aJp1+2O2K2YcC0Jwe0oWHl5WQPXtJ7uwzCwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974557; c=relaxed/simple;
	bh=14hM8KxFWjFayLbwQs4aNnXIF3yZXa0JAkdcIaa33gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW+WJ/7hv7jr5nbSeEPUpoL2IlxQLhC3ucxb3wBncuna8lHToDbWGdfrpcZBlycVEo3HF5StISLPZwh9oWor+D1ZPCHQqvP5CoZ+fLSlBH0gVr65ksXHw/kpiO3BQwgSEHx7JOWK+6B2OO5Z8vjMZ52XSmBQFGgViDHbkcGSIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6iuwG9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6iuwG9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03F21F00A3F
	for <linux-rtc@vger.kernel.org>; Thu, 28 May 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779974556;
	bh=14hM8KxFWjFayLbwQs4aNnXIF3yZXa0JAkdcIaa33gI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U6iuwG9sGH8cO3r+Nn/tL25qTkBHumd+0nhoNiPF8lDexhURU5YTYHTjJJ99dU8ey
	 ipExtdl/1mO/AWQRRsVC34KmEobHLhIkuv9uLxX6xXiHFEWVRCxWml2Lq0D93rUtJO
	 P6auQRDcYxyWyw2Na4X9g9i7/25PSGVx5KYmoZ0BYTaf0LlqTQfFFFn/bEePDENdZw
	 5BihZfwEWazwhfGj+QEsZTKkpK0tKa9B5W9WP5P/Oj5jCj30Nz3Tq6PDPMGFCavwyZ
	 ZPnbxLLt0+7QuHNLuLWP6fBaiOrlL2hKfJ/qVGLBSzUAcb3Jwd7sF4gq2M+S/x7SHR
	 voTZwzw0plh6Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so8078142e87.1
        for <linux-rtc@vger.kernel.org>; Thu, 28 May 2026 06:22:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/qmZS/U0jbhD7zBih4zHzgR5yKiJcVwIPQvjVwRyC87F+2cyctE2xjg7U6+J6NHnebxlB6lik8KGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRG5hOX4eHbUc6b64coGAwniGBDdmi2/9EO5I89f2P7L0OJr0
	53qon2vOM5nJNNhTDChPVL4LIW3cBplleg68MlcfGghjf/OObs8JWk2L5m8CdQPK9h1+I3t2jru
	PY107ae/BZj/poDBKN771LjKB+io/iGs=
X-Received: by 2002:a05:6512:1152:b0:5a8:6f3d:6cfc with SMTP id
 2adb3069b0e04-5aa32396b09mr9091774e87.41.1779974555411; Thu, 28 May 2026
 06:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779950275.git.u.kleine-koenig@baylibre.com> <a909d3c59d00756130ac16051ceedbec0ce9cec7.1779950275.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <a909d3c59d00756130ac16051ceedbec0ce9cec7.1779950275.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 28 May 2026 15:22:22 +0200
X-Gmail-Original-Message-ID: <CAD++jLkA1uQRCYyOYWBakwL1Poqt4xabbgBMz4WACqjCwv1hEw@mail.gmail.com>
X-Gm-Features: AVHnY4Jmb-2WCFIffZopygt2IA1H06egzEjWCuwLGLILjgUi_KzmLJfMf4CtuxY
Message-ID: <CAD++jLkA1uQRCYyOYWBakwL1Poqt4xabbgBMz4WACqjCwv1hEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] rtc: ab8500: Simplify driver_data handling
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:48=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:

> Instead of hiding the rtc ops for the only supported device behind an
> abstraction for multi-device support, hardcode the used ops which gets ri=
d
> of the need to call platform_get_device_id and two casts.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
