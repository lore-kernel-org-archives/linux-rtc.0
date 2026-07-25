Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576232B135;
	Sat, 25 Jul 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992412; cv=none; b=dHjvXIVzUStYGuw0oJLTAHYH3ZmsFYyBhLnl+nIYir6gDwCutKENN1WOdNYmZGIiP+17oWICtKfW4N31f8/FcJNuLVE8u/xcUvq2vLKGaT8dJwrFRubBFSDIjFW5k3272xh/W1Gt8+5AkR7QlODFmkipzcH4RFKsK7Ab1nORs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992412; c=relaxed/simple;
	bh=yvhfp/SHp31IC6sXZ4nWlFtB8vfKGy7QkXmYR88LilA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htAxcyBgbBtWueN/NRLns5KeHDxzgVZd1MOlCXEfkv+hdldSshpw1dYihAJT7RpDYFLzErgZfVDwzWp/1D0WJtD1eOcB/sBHIsUkqmarekh8D5/d0StjxJjlAvn0x7HSOySdWQOCZt9T8GbC9KYohdaRNPdvvZKHxrxCYZx89dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIgJRhGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIgJRhGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F055B1F000E9;
	Sat, 25 Jul 2026 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992410;
	bh=yvhfp/SHp31IC6sXZ4nWlFtB8vfKGy7QkXmYR88LilA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIgJRhGL/PytxYm5VQN1/e3vpGwlClTpgOVuG7EpiHGEyZ8J/4D1Kk0H3flui6bwE
	 OD8SqJk4E2sspbWGsSh19DqK68J14HFE6+dCO2OBQvzz0IbFblLKEINVgrOfloD+fV
	 qZA54t8icmnWM0tsGBIZ+D7B8pBNsYpOhdM2P0m2yspTZ5sxh9A+09ujbjsHT5/KY+
	 SMPKO/RaYBEsuK9zrxKtuWQ1BscZN7lrfY6W/NLHmA7r5oBmIJwpZ6DP3Uvm7mm+QZ
	 IWU6V7Rq4cWsAv9Zx4r/Cho26NsS2Ufoi+54sFf8RQ7XYctI0XLQs3nWovVijwdUUy
	 jdBICk3I6z6rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725145718.14733-8-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-8-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:13:29 +0000
Message-Id: <20260725151329.F055B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Move the I2C-specific code from abx80x_probe() to the newly created
> function. This is a preparation for introducing the support for
> ABX81X RTCs which use SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D7

